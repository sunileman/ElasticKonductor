#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e
#echo "1ClickESSDeploy.shopying variable files"
#cp -f ../variables.tf .
#cp -f ../terraform.tfvars .

# initialize terraform configuration
terraform init -upgrade

echo "1ClickESSDeploy.sh: validating configuration"
# validate terraform configuration
terraform validate

echo "1ClickESSDeploy.sh: creating plan"
# create terraform plan
terraform plan -out state.tfplan

echo "1ClickESSDeploy.sh: applying plan"
# apply terraform plan
terraform apply state.tfplan


bash ./getClusterInfo.sh

