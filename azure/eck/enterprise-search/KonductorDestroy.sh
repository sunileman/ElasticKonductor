#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e
echo "KonductorDestroy: EnterpriseSearch Copying variable files"
cp -f ../../variables.tf .
cp -f ../../terraform.tfvars .


echo "KonductorDestroy.sh EnterpriseSearch Refreshing AKS state"
(cd ../../aks; terraform init; terraform refresh)

echo "KonductorDestroy.sh EnterpriseSearch setting kubectl"
(cd ../../aks; bash ./setkubectl.sh)


terraform init
terraform refresh


echo "KonductorDestroy: Destroying EnterpriseSearch"
terraform destroy -auto-approve
