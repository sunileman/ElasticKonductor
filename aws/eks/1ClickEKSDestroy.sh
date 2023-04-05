#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
echo T1ClickEKSDestroy.sh: Terraform Destroy
set -e

echo "1ClickEKSDeploy.shopying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

set +e
echo "1ClickEKSDestroy.sh setting kubectl"
(bash ./setkubectl.sh)
set -e

terraform init -upgrade
set +e
terraform refresh
set -e

echo "1ClickEKSDestroy.sh: Destroying addons"
(cd ./addons; bash ./1ClickAddonsDestroy.sh )


echo "1ClickEKSDestroy.sh: Destroying AWS EKS"
terraform destroy -auto-approve
