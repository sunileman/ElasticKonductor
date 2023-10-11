#!/bin/bash

echo "KonductorDestroy.sh guardduty"
export KUBE_CONFIG_PATH=~/.kube/config

echo "ElasticKonductor/guardduty copy variable files"
cp -f ../../variables.tf .
cp -f ../../terraform.tfvars .

set -e

# initialize terraform configuration
terraform init -upgrade

# validate terraform configuration
terraform validate

echo "ElasticKonductor/guardduty: creating plan"
# create terraform plan
terraform plan -out state.tfplan

echo "ElasticKonductor/guardduty: applying plan"
# apply terraform plan
terraform apply state.tfplan


konductorvpc=$(terraform output vpcid | tr -d '"')

(bash ./delete-vpc-endpoint.sh $konductorvpc)
(bash ./delete-network-interfaces.sh $konductorvpc)
(bash ./delete-sg.sh $konductorvpc)