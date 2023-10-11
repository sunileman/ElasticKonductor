#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e

echo "Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

echo "1ClickECKDestroy.sh Refreshing EKS state"
(cd ../eks; terraform init -upgrade; terraform refresh)

echo "1ClickECKDestroy.sh Refresh ECK state"
terraform init -upgrade 

set +e
terraform refresh


echo "1ClickECKDestroy.sh setting kubectl"
(cd ../eks; bash ./setkubectl.sh)

set -e

echo "1ClickECKDestroy: Destroying license"
(cd ./license; bash ./1ClickAddLicenseDestroy.sh)

#remove entsearch
echo "1ClickECKDestroy.sh: Destroy enterprise search"
(cd ./enterprise-search ; bash ./KonductorDestroy.sh) 


echo "Destroying ES Pods"
terraform destroy -auto-approve

(cd ./es-operator ; bash ./1ClickECKOperatorDestroy.sh)

#delete ebs volumes
#bash delete-ebs-volumes.sh
