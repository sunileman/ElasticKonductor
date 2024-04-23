#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config

set -e
echo "1ClickECKDestroy: Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .



echo "1ClickECKDestroy.sh Refreshing AKS state"
(cd ../aks; terraform init; terraform refresh)

echo "1ClickECKDestroy.sh setting kubectl"
(cd ../aks; bash ./setkubectl.sh)


terraform init
terraform refresh


echo Terraform Destroy
echo "1ClickECKDestroy: Destroying license"
(cd ./license; bash ./1ClickAddLicenseDestroy.sh)


echo "1ClickECKDeploy.sh: Destroying Elastic Agent"
(cd ./helm-deployment/eck-agent/; bash ./KonductorDestroy.sh)

echo "1ClickECKDeploy.sh: Destroying Fleet Server"
(cd ./helm-deployment/eck-fleet-server/; bash ./KonductorDestroy.sh)

echo "1ClickECKDeploy.sh: Destroying Kibana"
(cd ./helm-deployment/eck-kibana/; bash ./KonductorDestroy.sh)


echo "1ClickECKDeploy.sh: Destroying Elasticsearch"
(cd ./helm-deployment/eck-elasticsearch/; bash ./KonductorDestroy.sh)

echo "1ClickECKDeploy.sh: Destroying Elastic CRDS and Operator"
(cd ./helm-deployment/eck-operator/; bash ./KonductorDestroy.sh)


echo "1ClickECKDeploy.sh: Creating Loadbalancers"
(cd ./loadbalancers/; bash ./KonductorDestroy.sh)
