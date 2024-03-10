#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-destroy-$nowtime.log"

set -e

echo "opentelemetry-demo/1ClickAddonsDestroy.sh: coping variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .

terraform init
terraform refresh

echo "opentelemetry-demo/1CLickAddonsDestroy.sh: Terraform Destroy"
terraform destroy -auto-approve