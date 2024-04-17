#!/bin/bash
set -e
echo "getClusterInfo.sh"
clusternameraw=$(terraform output clustername)
clustername=${clusternameraw//\"/}
regionraw=$(terraform output region)
region=${regionraw//\"/}
fleet_inst=$(terraform output fleet_pod)
fleet_pod=$(terraform output fleet_instance)

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Checking if license file is exists
echo ...
echo ...
if test -f ./license/es-license.json; then
  echo License file found and should have been applied to ECK
else
  echo No license file found. Make sure it is named es-license.json and placed under ./eck/license
  echo Enterprise Trial license applied.
fi

# Function to check if the Kubernetes secret exists
check_secret() {
  kubectl get secret eck-elasticsearch-es-elastic-user &>/dev/null
  return $?
}

SLEEP_INTERVAL=20 # in seconds

# Check the secret and exit if it doesn't exist after some retries
SECRET_RETRIES=5
secret_count=0
while ! check_secret; do
  secret_count=$((secret_count + 1))
  if [ $secret_count -ge $SECRET_RETRIES ]; then
    echo "Error: Kubernetes secret 'eck-elasticsearch-es-elastic-user' not found after $SECRET_RETRIES attempts."
    exit 1
  fi
  echo "Secret 'eck-elasticsearch-es-elastic-user' not found, retrying in $SLEEP_INTERVAL seconds..."
  sleep $SLEEP_INTERVAL
done


# Function to check if Elasticsearch is ready
check_es() {
  RESPONSE=$(curl --insecure -s -u elastic:$(kubectl get secret eck-elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode) https://$(kubectl get service eck-ingest-es-http-endpoint | tail -n -1 | awk {'print $4"" '}):9200)
  if echo "$RESPONSE" | grep -q "You Know, for Search"; then
    echo "$RESPONSE" # If the desired string is found, print the entire payload
    return 0
  else
    return 1
  fi
}

RETRIES=20

# Retry mechanism
count=0
until check_es; do
  count=$((count + 1))
  if [ $count -ge $RETRIES ]; then
    echo "Failed to get the expected response from Elasticsearch after $RETRIES attempts."
    exit 1
  fi
  echo "Elasticsearch not ready, retrying in $SLEEP_INTERVAL seconds..."
  sleep $SLEEP_INTERVAL
done



ipsplit() {
    local IFS=.
    echo $*
}

check_fleet() {
    local retries=20
    local wait_time=20

    for i in $(seq 1 $retries); do
        ip=$(kubectl get service fleet-server-agent-http -o=jsonpath='{.spec.clusterIP}' 2>/dev/null)
        if [[ "$ip" != "<pending>" && ! -z "$ip" ]]; then
             >&2 echo "Fleet is ready. It may take a few minutes for the Fleet Agent to appear in Kibana."
            return 0
        else
            >&2 echo "Fleet is not ready. Retrying in $wait_time seconds..." 
            sleep $wait_time
        fi
    done

    >&2 echo "Failed to deploy Fleet after $retries retries."
    echo "<unavailable>"
    return 1
}

get_service_ip() {
    local service_name="$1"
    local retries=10
    local wait_time=20

    for i in $(seq 1 $retries); do
        ip=$(kubectl get service $service_name -o=jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null)
        if [[ "$ip" != "<pending>" && ! -z "$ip" ]]; then
            echo $ip
            return 0
        else
            >&2 echo "IP for $service_name is not ready. Retrying in $wait_time seconds..." 
            sleep $wait_time
        fi
    done

    >&2 echo "Failed to retrieve IP for $service_name after $retries retries."
    echo "<unavailable>"
    return 1
}



# Use the function to get the IPs
ingest_ip=$(get_service_ip "eck-ingest-es-http-endpoint")
search_ip=$(get_service_ip "eck-search-es-http-endpoint")
kibana_ip=$(get_service_ip "eck-kibana-kb-http")


kibana_password=$(kubectl get secret eck-elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

kurl_kibana=$(kubectl get service eck-kibana-kb-http | tail -n -1 | awk '{print $4}')
set -- `ipsplit $kurl_kibana`
k1=$4.$3.$2.$1

kurl_ingest=$(kubectl get service eck-ingest-es-http-endpoint | tail -n -1 | awk '{print $4}')
set -- `ipsplit $kurl_ingest`
k2=$4.$3.$2.$1

kurl_search=$(kubectl get service eck-search-es-http-endpoint | tail -n -1 | awk '{print $4}')
set -- `ipsplit $kurl_search`
k3=$4.$3.$2.$1

# Display information
echo "================================================="
echo "                     Cluster Info"
echo "================================================="

echo "Cluster Name: $clustername"
echo "Region: $region"
echo

echo "Elasticsearch Ingest Endpoint:"
echo "- IP: https://$ingest_ip:9200"
echo "- DNS: https://$k2.bc.googleusercontent.com:9200"
echo

echo "Elasticsearch Search Endpoint:"
echo "- IP: https://$search_ip:9200"
echo "- DNS: https://$k3.bc.googleusercontent.com:9200"
echo

echo "Kibana:"
echo "- URL (IP): https://$kibana_ip:5601"
echo "- URL (DNS): https://$k1.bc.googleusercontent.com:5601"

echo
echo "Elasticsearch Credentials:"
echo "- UserName: elastic"
echo "- Password: $kibana_password"
echo

if [[ $fleet_inst > 0 || $fleet_pod > 0 ]]; then
    echo "Fleet Status:" 
    $(check_fleet)
fi
echo
echo "NOTE: It may take a few minutes for the Kibana UI to come up."
echo "================================================="



