#!/bin/bash

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-destroy-$nowtime.log"



echo "1CLickECKOperatorDestroy.sh destroy operator"
(cd ./create-operator; bash KonductorDestroy.sh)

set -e
echo "1CLickECKOperatorDestroy.sh: Copying variable files"
cp -f ../../variables.tf .
cp -f ../../terraform.tfvars .

terraform init -upgrade
terraform refresh

echo "1CLickECKOperatorDestroy.sh: Terraform Destroy"
terraform destroy -auto-approve