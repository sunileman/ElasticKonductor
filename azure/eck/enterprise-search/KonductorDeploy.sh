#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config


set -e
#copy variables to operator directory
echo "KonductorDeploy.sh: EnterpriseSearch coping variable files"
cp -f ../../variables.tf .
cp -f ../../terraform.tfvars .


echo "KonductorDeploy.sh: creating EnterpriseSearch" 
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan

# apply terraform plan
terraform apply state.tfplan

