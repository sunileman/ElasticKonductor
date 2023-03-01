#!/bin/bash
echo "iscsi/1ClickAddons.sh: adding iscsi"
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

echo "iscsi/1ClickAddons.sh: coping variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .


export KUBE_CONFIG_PATH=~/.kube/config

set -e

echo "iscsi/1ClickAddons.sh: creating  iscsi"
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan
echo "iscsi/1ClickAddons.sh: finished creating iscsi"
