#!/bin/bash

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"


export KUBE_CONFIG_PATH=~/.kube/config
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

set -e

echo "1ClickLogStashDeploy.sh: Copying variable files"
cp -f ../../variables.tf .
cp -f ../../terraform.tfvars .


echo "1ClickLogStashDeploy.sh: Creating LogStash Nodes"
# initialize terraform configuration
terraform init -upgrade

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan
