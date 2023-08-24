#!/bin/bash

set -e
##get variables from terraform state
lbnameraw=$(terraform output lbname)
lbname=${lbnameraw//\"/}

lb2nameraw=$(terraform output lb2name)
lb2name=${lb2nameraw//\"/}

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
echo "K8s Cluster Name: $clustername"
echo "K8s Region: $region"
echo
echo ES URL[IP]: https://$(kubectl get service eck-external-es-http | tail -n -1 | awk {'print $4"" '}):9200
echo or
echo ES URL[DNS]: https://$lb2name.$region.cloudapp.azure.com:9200
echo
echo Kibana URL[IP]: https://$(kubectl get service eck-kb-http | tail -n -1 | awk {'print $4"" '}):5601
echo or
echo Kibana URL[DNS]: https://$lbname.$region.cloudapp.azure.com:5601
echo
echo Kibana UserName: elastic
echo Kibana Password: $(kubectl get secret eck-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)
echo PLEASE NOTE: It may take a few minutes for the kibana UI to come up
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
