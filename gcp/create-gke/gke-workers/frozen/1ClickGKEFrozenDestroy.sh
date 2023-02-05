#!/bin/bash

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-destroy-$nowtime.log"

echo "1ClickGKEFrozenDestroy.sh: Terraform Destroy"
set -e

terraform destroy -auto-approve
