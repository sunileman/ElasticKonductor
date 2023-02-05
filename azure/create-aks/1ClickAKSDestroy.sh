#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
echo "1ClickAKSDestroy.sh: Terraform Destroy"
set -e

echo "1ClickAKSDestroy.sh: destroying ksm addon"
(cd ./addons/ksm; terraform destroy -auto-approve)

set +e
echo "1ClickAKSDestroy.sh: destroying openebs addon"
(cd ./addons/openebs; terraform destroy -auto-approve)
set -e

echo "1ClickAKSDestroy.sh: destroying AKS"
terraform destroy -auto-approve
