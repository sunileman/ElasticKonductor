#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e

echo "Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

terraform init 
terraform refresh

echo "1ClickECKDestroy.sh setting kubectl"
(cd ../eks; bash ./setkubectl.sh)

echo "1ClickECKDestroy: Destroying license"
(cd ./license; bash ./1ClickAddLicenseDestroy.sh)

echo "Destroying ES Pods"
terraform destroy -auto-approve

(cd ./es-operator ; bash ./1ClickECKOperatorDestroy.sh)
