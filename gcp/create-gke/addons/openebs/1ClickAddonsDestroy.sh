#!/bin/bash
set -e
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

terraform init
terraform refresh


export KUBE_CONFIG_PATH=~/.kube/config
echo "openebs/1ClickAddonsDestroy.sh Terraform Destroy"
terraform destroy -auto-approve
