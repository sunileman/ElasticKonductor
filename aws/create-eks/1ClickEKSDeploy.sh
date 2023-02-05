#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e
echo "C1ClickEKSDeploy.shopying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

# initialize terraform configuration
terraform init

echo "1ClickEKSDeploy.sh: Creating AWS EKS Infra" 
echo "1ClickEKSDeploy.sh: validating configuration"
# validate terraform configuration
terraform validate

echo "1ClickEKSDeploy.sh: creating plan"
# create terraform plan
terraform plan -out state.tfplan

echo "1ClickEKSDeploy.sh: applying plan"
# apply terraform plan
terraform apply state.tfplan

echo "1ClickEKSDeploy.sh: Running addons"
(cd addons; bash ./1ClickAddons.sh)

# cleanup
#terraform destroy -auto-approve
