#!/bin/bash
set -e

## Get variables from terraform state
clusternameraw=$(terraform output clustername)
clustername=${clusternameraw//\"/}
regionraw=$(terraform output region)
region=${regionraw//\"/}

echo "============================================================"
echo "Checking if license file exists"
echo "============================================================"
if test -f ./license/es-license.json; then
  echo "License file found and should have been applied to ECK"
else
  echo "No license file found. Make sure it is named es-license.json and placed under ./eck/license"
  echo "Enterprise Trial license applied."
fi
echo "============================================================"

RETRIES=20
SLEEP_INTERVAL=20 # in seconds

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


# Get Ingest LoadBalancer IP and Hostname
ingest_ip=$(kubectl get service eck-ingest-es-http-endpoint -o=jsonpath='{.spec.clusterIP}')
ingest_hostname=$(kubectl get service eck-ingest-es-http-endpoint -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Get Search LoadBalancer IP and Hostname
search_ip=$(kubectl get service eck-search-es-http-endpoint -o=jsonpath='{.spec.clusterIP}')
search_hostname=$(kubectl get service eck-search-es-http-endpoint -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Get Kibana LoadBalancer IP and Hostname
kibana_ip=$(kubectl get service eck-kibana-kb-http -o=jsonpath='{.spec.clusterIP}')
kibana_hostname=$(kubectl get service eck-kibana-kb-http -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Get Kibana Password
kibana_password=$(kubectl get secret eck-elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

echo "============================================================"
echo "                      CLUSTER INFO                          "
echo "============================================================"
printf "\n"
printf "K8s Cluster Name: %-15s \n" "$clustername"
printf "K8s Region: %-15s \n" "$region"
printf "\n"

echo "---------------------- Ingest Endpoint ----------------------"
printf "IP Address:   https://%s:9200\n" "$ingest_ip"
printf "Hostname:     https://%s:9200\n" "$ingest_hostname"
printf "\n"

echo "---------------------- Search Endpoint ----------------------"
printf "IP Address:   https://%s:9200\n" "$search_ip"
printf "Hostname:     https://%s:9200\n" "$search_hostname"
printf "\n"

echo "------------------------ Kibana URL -------------------------"
printf "IP Address:   https://%s:5601\n" "$kibana_ip"
printf "Hostname:     https://%s:5601\n" "$kibana_hostname"
printf "\n"

echo "---------------------- Kibana Credentials --------------------"
printf "Username: %-10s\n" "elastic"
printf "Password: %-10s\n" "$kibana_password"
printf "\n"

echo "NOTE: It may take a few minutes for the Kibana UI to come up."
printf "\n"
echo "============================================================"
echo "============================================================"
