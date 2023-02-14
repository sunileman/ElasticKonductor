#!/bin/bash
echo "openebs/1ClickAddons.sh: adding openebs"
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

echo "openebs/1ClickAddons.sh: coping variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .


export KUBE_CONFIG_PATH=~/.kube/config

set -e

echo "openebs/1ClickAddons.sh: creating openebs"
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan
echo "openebs/1ClickAddons.sh: finished creating openebs"
