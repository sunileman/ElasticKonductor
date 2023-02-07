#!/bin/bash

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-destroy-$nowtime.log"


set -e

echo "1ClickFrozenDestroy.sh: Copying variable files"
cp -f ../../variables.tf .
cp -f ../../terraform.tfvars .

terraform init
terraform refresh

echo "1ClickGKEFrozenDestroy.sh: Terraform Destroy"
terraform destroy -auto-approve
