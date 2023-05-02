#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
echo "1ClickESSDestroy.sh: Terraform Destroy"
set -e

#echo "1ClickESSDeploy.shopying variable files"
#cp -f ../variables.tf .
#cp -f ../terraform.tfvars .


terraform init -upgrade
set +e
terraform refresh
set -e


echo "1ClickESSDestroy.sh: Destroying ESS"
terraform destroy -auto-approve
