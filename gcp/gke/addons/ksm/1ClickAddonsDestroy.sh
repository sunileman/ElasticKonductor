#!/bin/bash

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-destroy-$nowtime.log"

export KUBE_CONFIG_PATH=~/.kube/config
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

set -e

echo "ksm/1ClickAddonsDestroy.sh: coping variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .

terraform init -upgrade
terraform refresh

echo "ksm/1CLickAddonsDestroy.sh: Terraform Destroy"
terraform destroy -auto-approve