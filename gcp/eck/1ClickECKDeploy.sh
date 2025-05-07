#!/bin/bash


echo "1ClickECKDeploy.sh: Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

set -e

echo "1ClickECKDeploy.sh: Fetching helm elastic repo"
helm repo add elastic https://helm.elastic.co
helm repo update

echo "1ClickECKDeploy.sh: Creating Elastic CRDS and Operator"
(cd ./helm-deployment/eck-operator/; bash ./KonductorDeploy.sh)

echo "1ClickECKDeploy.sh Creating ElasticSearch Pods"
# initialize terraform configuration
terraform init -upgrade

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan

#add entsearch
echo "1ClickECKDeploy.sh: checking enterprise search count"
count=$(grep -E '^#?entsearch_instance_count' terraform.tfvars | head -1 | awk -F '=' '{print $2}' | tr -d '[:space:]')
echo "Entsearch count: $count"
if [ $count -gt 0 ]; then
    echo "1ClickECKDeploy.sh: Add enterprise search.  Please wait..."
    sleep 120
    (cd ./enterprise-search ; bash ./KonductorDeploy.sh) 
else
    echo "1ClickECKDeploy.sh: Skipping building entsearch pods due to entsearch_instance_count being 0 or not set."
fi



echo "1ClickECKDeploy.sh: Appling license"
#add license file
(cd ./license ; bash ./1ClickAddLicense.sh) 

echo "1ClickECKDeploy.sh: Calling eck/getClusterInfo.sh"
./getClusterInfo.sh
