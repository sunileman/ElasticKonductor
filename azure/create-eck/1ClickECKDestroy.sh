#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e
echo "Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .
cp -f ../variables.tf ./create-operator/variables.tf
cp -f ../terraform.tfvars ./create-operator/variables.tfvars


echo Terraform Destroy
echo "Destroying License"
(cd ./license; terraform destroy -auto-approve)


echo "Destroying ES Pods"
terraform destroy -auto-approve


echo "Destroying Operator" 
(cd ./create-operator ; terraform destroy -auto-approve)


echo "Destroying NameGen"
(cd ./namegen ; terraform destroy -auto-approve)
