#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
set -e

echo "1ClickAKSDestroy.sh: coping variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

echo "1ClickAKSDestroy.sh setting kubectl"
(bash ./setkubectl.sh)

terraform init
terraform refresh

echo "1ClickAKSDestroy.sh: destroying addons"
(cd ./addons; bash ./1ClickAddonsDestroy.sh)


echo "1ClickAKSDestroy.sh: destroying AKS"
terraform destroy -auto-approve
