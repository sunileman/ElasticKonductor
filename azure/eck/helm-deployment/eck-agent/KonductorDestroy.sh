#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-destroy-$nowtime.log"



echo "KonductorDestroy.sh eck-agent: Copying variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .

terraform init -upgrade
terraform refresh

echo "KonductorDestroy.sh eck-agent: Terraform Destroy"
terraform destroy -auto-approve