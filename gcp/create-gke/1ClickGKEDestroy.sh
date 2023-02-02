#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config
echo Terraform Destroy
set -e
(cd ./addons/ksm; terraform destroy -auto-approve 2>/dev/null)
(cd ./addons/openebs; terraform destroy -auto-approve 2>/dev/null)
terraform destroy -auto-approve 2>/dev/null