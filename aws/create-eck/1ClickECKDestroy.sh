#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e

terraform init 
terraform refresh

echo "Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .


echo "1ClickECKDestroy: Destroying license"
(cd ./license; bash ./1ClickAddLicenseDestroy.sh)

echo "Destroying ES Pods"
terraform destroy -auto-approve

(cd ./create-operator ; bash ./1ClickECKOperatorDestroy.sh)
