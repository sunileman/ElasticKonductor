#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e
echo "1ClickECKDestroy: Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

terraform init
terraform refresh


echo Terraform Destroy
echo "1ClickECKDestroy: Destroying license"
(cd ./license; bash ./1ClickAddLicenseDestroy.sh)


echo "1ClickECKDestroy: Destroying ES Pods"
terraform destroy -auto-approve


echo "1ClickECKDestroy:  Destroying Operator" 
(cd ./create-operator ; bash ./1ClickECKOperatorDestroy.sh)
