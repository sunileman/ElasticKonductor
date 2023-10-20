#!/bin/bash

##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"


export USE_GKE_GCLOUD_AUTH_PLUGIN=True
set -e 
echo "KonductorDeploy.sh create-operator: Copying variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .


export KUBE_CONFIG_PATH=~/.kube/config
echo "KonductorDeploy.sh create-operator: creating ECK Operator"
# initialize terraform configuration
terraform init -upgrade

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan

echo "KonductorDeploy.sh: Finished creating ECK Operator"
