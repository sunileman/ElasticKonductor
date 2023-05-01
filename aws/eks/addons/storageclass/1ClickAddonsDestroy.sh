#!/bin/bash
set -e
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

echo "storageclass/1ClickAddons.sh: coping variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .

terraform init -upgrade
terraform refresh


export KUBE_CONFIG_PATH=~/.kube/config
echo "storageclass/1ClickAddonsDestroy.sh Terraform Destroy"
terraform destroy -auto-approve
