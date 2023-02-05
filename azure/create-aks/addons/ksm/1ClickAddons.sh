#!/bin/bash
echo "ksm/1ClickAddons.sh: adding ksm"
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"


export KUBE_CONFIG_PATH=~/.kube/config
set -e
echo "ksm/1ClickAddons.sh: creating ksm"
##terraform logs
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan
echo "ksm/1ClickAddons.sh: finished creating ksm"
