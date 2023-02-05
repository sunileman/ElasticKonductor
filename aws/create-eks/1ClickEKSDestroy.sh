#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
echo T1ClickEKSDestroy.sh: Terraform Destroy
set -e

echo "1ClickEKSDestroy.sh: Destroying KSM addon"
(cd ./addons/ksm; terraform destroy -auto-approve)

echo "1ClickEKSDestroy.sh Destroying autoscaler addon"
(cd ./addons/autoscaler; terraform destroy -auto-approve)

echo "1ClickEKSDestroy.sh: Destroying openebs addon"
set +e
(cd ./addons/openebs; terraform destroy -auto-approve)
set -e

echo "1ClickEKSDestroy.sh: Destroying AWS EKS"
terraform destroy -auto-approve
