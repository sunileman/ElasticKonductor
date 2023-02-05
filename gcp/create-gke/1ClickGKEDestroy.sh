#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config
echo "1ClickGKEDestroy.sh: Terraform Destroy"
set -e

echo "1ClickGKEDestroy.sh: destroying ksm"
(cd ./addons/ksm; terraform destroy -auto-approve)
echo "1ClickGKEDestroy.sh: finish destroying ksm"

echo "1ClickGKEDestroy.sh: destroying openEBS"
(cd ./addons/openebs; terraform destroy -auto-approve)
echo "1ClickGKEDestroy.sh: finished destroying openEBS"

echo "1ClickGKEDestroy.sh: destroying GKE node pools"
(cd ./gke-workers; bash ./1ClickGKEWorkersDestroy.sh)
echo "1ClickGKEDestroy.sh: finished GKE node pools"

echo "1ClickGKEDestroy.sh: destroying GKE"
terraform destroy -auto-approve
echo "1ClickGKEDestroy.sh: finished destroying GKE"
