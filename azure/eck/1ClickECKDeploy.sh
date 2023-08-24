#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config
##Name Gen Util for AKS Kibana Load Balancer

echo "1ClickECKDeploy.sh: generating name"
(cd ./namegen; bash ./1ClickNameGen.sh )

set -e
#copy variables to operator directory
echo "1ClickECKDeploy.sh: coping variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

##create elastic CRDs and Operator
echo "1ClickECKDeploy.sh: Creating Elastic CRDS and Operator"
(cd ./es-operator ; bash ./1ClickECKOperator.sh)

echo "1ClickECKDeploy.sh: creating ECK" 
# initialize terraform configuration
terraform init

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
if [[ $count -gt 0 ]]; then
    echo "1ClickECKDeploy.sh: Add enterprise search.  Please wait..."
    sleep 120
    (cd ./enterprise-search ; bash ./KonductorDeploy.sh) 
else
    echo "1ClickECKDeploy.sh: Skipping building entsearch pods due to entsearch_instance_count being 0 or not set."
fi


#add license file
echo "1ClickECKDeploy.sh: Adding trial license"
(cd ./license ; bash ./1ClickAddLicense.sh) 

echo "1ClickECKDeploy.sh: Calling eck/getClusterInfo.sh"
./getClusterInfo.sh
