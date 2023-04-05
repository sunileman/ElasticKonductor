#!/bin/bash

##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

echo "1ClickECKDeploy.sh: Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

set -e
##create elastic CRDs and Operator
echo "1ClickECKDeploy.sh: Creating Elastic CRDS and Operator"
(cd ./es-operator ; sh ./1ClickECKOperator.sh)


echo "1ClickECKDeploy.sh Creating ElasticSearch Pods"
# initialize terraform configuration
terraform init -upgrade

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan

echo "1ClickECKDeploy.sh: Appling license"
#add license file
(cd ./license ; bash ./1ClickAddLicense.sh) 


echo Please wait....
sleep 60
./getClusterInfo.sh
