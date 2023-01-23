#!/bin/bash
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
echo "Copying variable files"
cp -f ../../variables.tf .
cp -f ../../terraform.tfvars .


export KUBE_CONFIG_PATH=~/.kube/config
echo ECK Operator
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan
