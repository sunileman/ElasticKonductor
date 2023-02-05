#!/bin/bash
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"


set +e
echo "1ClickRemoveOpenEBS.sh: OpenEBS Destroy"
export KUBE_CONFIG_PATH=~/.kube/config
terraform destroy -auto-approve
set -e
