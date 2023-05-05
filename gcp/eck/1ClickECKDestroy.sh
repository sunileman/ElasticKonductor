#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config
set -e

echo "1ClickECKDestroy.sh Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .
cp -f ../variables.tf ./es-operator/variables.tf
cp -f ../terraform.tfvars ./es-operator/variables.tfvars


echo "1ClickECKDestroy.sh Refreshing GKE state"
(cd ../gke; terraform init -upgrade; terraform refresh)

echo "1ClickECKDestroy.sh Refresh ECK state"
terraform init -upgrade
terraform refresh

echo "1ClickECKDestroy.sh setting kubectl"
(cd ../gke; bash ./setkubectl.sh)

echo "1ClickECKDestroy.sh Terraform Destroy"
echo "1ClickECKDestroy.sh Destroying License"
(cd ./license; ./1ClickAddLicenseDestroy.sh)
echo "1ClickECKDestroy.sh finished Destroying License"

echo "1ClickECKDestroy.sh Destroying ES Pods"
terraform destroy -auto-approve
echo "1ClickECKDestroy.sh finished Destroying ES Pods"

echo "1ClickECKDestroy.sh Destroying Operator"
(cd ./es-operator; ./1ClickECKOperatorDestroy.sh)
echo "1ClickECKDestroy.sh finished Destroying Operator"
