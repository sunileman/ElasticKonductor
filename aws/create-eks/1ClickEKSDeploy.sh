#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

echo "Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

# initialize terraform configuration
terraform init

echo "validating configuration"
# validate terraform configuration
terraform validate

echo "creating plan"
# create terraform plan
terraform plan -out state.tfplan

echo "applying plan"
# apply terraform plan
terraform apply state.tfplan

echo "Running addons"
(cd addons; bash ./1ClickAddons.sh)

# cleanup
#terraform destroy -auto-approve
