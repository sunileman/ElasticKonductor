#!/bin/bash
echo "istio/1ClickAddons.sh: adding istio"
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

echo "istio/1ClickAddons.sh: coping variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .


export KUBE_CONFIG_PATH=~/.kube/config

set -e

echo "istio/1ClickAddons.sh: creating istio"
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan
echo "istio/1ClickAddons.sh: finished creating istio"
