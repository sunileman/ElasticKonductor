#!/bin/bash
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
  echo No license file found. Make sure it is named es-license.json and placed under ./eck/license
  echo Enterprise Trial license applied.
fi

RETRIES=20
SLEEP_INTERVAL=20 # in seconds

# Function to check if Elasticsearch is ready
check_es() {
  RESPONSE=$(curl --insecure -s -u elastic:$(kubectl get secret eck-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode) https://$(kubectl get service eck-external-es-http | tail -n -1 | awk {'print $4"" '}):9200)
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

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Cluster Info
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "Cluster Name: $clustername"
echo "Region: $region"
echo
echo ES URL: https://$(kubectl get service eck-external-es-http | tail -n -1 | awk {'print $4"" '}):9200
echo Kibana URL: https://$(kubectl get service eck-kb-http | tail -n -1 | awk {'print $4"" '}):5601
echo Kibana UserName: elastic
echo Kibana Password: $(kubectl get secret eck-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)
echo PLEASE NOTE: It may take a few minutes for the kibana UI to come up
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
