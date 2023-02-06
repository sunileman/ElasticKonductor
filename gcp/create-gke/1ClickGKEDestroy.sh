#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config

terraform init

echo "1ClickGKEDestroy.sh: Terraform Destroy"
set -e

echo "1ClickGKEDestroy.sh: destroying addons"
(cd ./addons; ./1ClickAddonsDestroy.sh)


echo "1ClickGKEDestroy.sh: destroying GKE node pools"
(cd ./gke-workers; bash ./1ClickGKEWorkersDestroy.sh)
echo "1ClickGKEDestroy.sh: finished GKE node pools"

echo "1ClickGKEDestroy.sh: destroying GKE"
terraform destroy -auto-approve
echo "1ClickGKEDestroy.sh: finished destroying GKE"
