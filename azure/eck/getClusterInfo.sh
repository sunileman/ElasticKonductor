#!/bin/bash

set -e
##get variables from terraform state
lbnameraw=$(terraform output lbname)
lbname=${lbnameraw//\"/}

ingestLBnameraw=$(terraform output ingestLbName)
ingestLBname=${ingestLBnameraw//\"/}

searchLBnameraw=$(terraform output searchLbName)
searchLBname=${searchLBnameraw//\"/}

clusternameraw=$(terraform output clustername)
clustername=${clusternameraw//\"/}

regionraw=$(terraform output region)
region=${regionraw//\"/}

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Checking if license file is exists
echo ...
echo ...
if test -f ./license/es-license.json; then
  echo License file found and should have been applied to ECK
else
  echo No license file found. Make sure it is named es-license.json and placed under ./create-eck/license
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


RETRIES=20

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


# Fetch service URLs and credentials
ingest_ip=$(kubectl get service eck-ingest-es-http-endpoint -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
search_ip=$(kubectl get service eck-search-es-http-endpoint -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
kibana_ip=$(kubectl get service eck-kibana-kb-http -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
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
printf "DNS Address:  https://%s.%s.cloudapp.azure.com:9200\n" "$ingestLBname" "$region"
printf "\n"

echo "---------------------- Search Endpoint ----------------------"
printf "IP Address:   https://%s:9200\n" "$search_ip"
printf "DNS Address:  https://%s.%s.cloudapp.azure.com:9200\n" "$searchLBname" "$region"
printf "\n"

echo "------------------------ Kibana URL -------------------------"
printf "IP Address:   https://%s:5601\n" "$kibana_ip"
printf "DNS Address:  https://%s.%s.cloudapp.azure.com:5601\n" "$lbname" "$region"
printf "\n"

echo "---------------------- Elasticsearch Credentials --------------------"
printf "Username: %-10s\n" "elastic"
printf "Password: %-10s\n" "$kibana_password"
printf "\n"

echo "NOTE: It may take a few minutes for the Kibana UI to come up."
printf "\n"
echo "============================================================"
echo "============================================================"
