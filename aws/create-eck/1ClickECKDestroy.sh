#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
echo Terraform Destroy
terraform destroy -auto-approve 2>/dev/null
(cd ./create-operator ; terraform destroy -auto-approve 2>/dev/null)
