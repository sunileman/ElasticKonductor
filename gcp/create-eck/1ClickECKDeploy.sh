#!/bin/bash

##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

echo "Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

set -e
##create elastic CRDs and Operator
echo Creating Elastic CRDS and Operator
(cd ./create-operator ; sh ./1ClickECKOperator.sh)


# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan

#add license file
./license/1ClickAddLicense.sh


echo Please wait....
sleep 120
./getClusterInfo.sh
