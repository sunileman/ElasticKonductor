#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e
echo "1ClickECKDestroy: Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .


echo "1ClickECKDestroy.sh calling nameGen"
(cd ./namegen; bash ./1ClickNameGen.sh)

echo "1ClickECKDestroy.sh Refreshing AKS state"
(cd ../aks; terraform init; terraform refresh)

echo "1ClickECKDestroy.sh setting kubectl"
(cd ../aks; bash ./setkubectl.sh)


terraform init
terraform refresh


echo Terraform Destroy
echo "1ClickECKDestroy: Destroying license"
(cd ./license; bash ./1ClickAddLicenseDestroy.sh)


echo "1ClickECKDestroy: Destroying ES Pods"
terraform destroy -auto-approve


echo "1ClickECKDestroy:  Destroying Operator" 
(cd ./es-operator ; bash ./1ClickECKOperatorDestroy.sh)

echo "1ClickAKSDestroy: Destroying NameGen"
(cd ./namegen/; bash ./1ClickNameGenDestroy.sh)