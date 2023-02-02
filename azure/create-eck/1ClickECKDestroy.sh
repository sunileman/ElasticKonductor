#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

echo "Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .
cp -f ../variables.tf ./create-operator/variables.tf
cp -f ../terraform.tfvars ./create-operator/variables.tfvars


echo Terraform Destroy
(cd ./license; terraform destroy -auto-approve 2>/dev/null)
(cd ./namegen ; terraform destroy -auto-approve 2>/dev/null)
terraform destroy -auto-approve 2>/dev/null
(cd ./create-operator ; terraform destroy -auto-approve 2>/dev/null)
