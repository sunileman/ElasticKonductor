#!/bin/bash

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-destroy-$nowtime.log"

set -e

terraform init
terraform refresh

echo "1CLickNameGenDestroy.sh: Terraform Destroy"
terraform destroy -auto-approve