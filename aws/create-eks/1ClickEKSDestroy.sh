#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
echo T1ClickEKSDestroy.sh: Terraform Destroy
set -e

terraform init
terraform refresh

echo "1ClickEKSDestroy.sh: Destroying addons"
(cd ./addons; bash ./1ClickAddonsDestroy.sh )


echo "1ClickEKSDestroy.sh: Destroying AWS EKS"
terraform destroy -auto-approve
