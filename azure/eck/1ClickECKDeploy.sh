#!/bin/bash

#add license file
echo "1ClickECKDeploy.sh: set kubectl"
(cd ../aks/ ; bash ./setkubectl.sh) 

export KUBE_CONFIG_PATH=~/.kube/config
##Name Gen Util for AKS Kibana Load Balancer

echo "1ClickECKDeploy.sh: generating name"
(cd ./namegen; bash ./1ClickNameGen.sh)

set -e
#copy variables to operator directory
echo "1ClickECKDeploy.sh: coping variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

echo "1ClickECKDeploy.sh: Creating Loadbalancers"
(cd ./loadbalancers/; bash ./KonductorDeploy.sh)

echo "1ClickECKDeploy.sh: Creating Elastic CRDS and Operator"
(cd ./helm-deployment/eck-operator/; bash ./KonductorDeploy.sh)


echo "1ClickECKDeploy.sh: Creating Elasticsearch"
(cd ./helm-deployment/eck-elasticsearch/; bash ./KonductorDeploy.sh)

echo "1ClickECKDeploy.sh: Creating Kibana"
(cd ./helm-deployment/eck-kibana/; bash ./KonductorDeploy.sh)

echo "1ClickECKDeploy.sh: Creating Elastic Agent"
(cd ./helm-deployment/eck-agent/; bash ./KonductorDeploy.sh)

echo "1ClickECKDeploy.sh: Creating Fleet Server"
(cd ./helm-deployment/eck-fleet-server/; bash ./KonductorDeploy.sh)


#add entsearch
echo "1ClickECKDeploy.sh: checking enterprise search count"
count=$(grep -E '^#?entsearch_instance_count' terraform.tfvars | head -1 | awk -F '=' '{print $2}' | tr -d '[:space:]')
echo "Entsearch count: $count"
if [ $count -gt 0 ]; then
    echo "1ClickECKDeploy.sh: Add enterprise search.  Please wait..."
    sleep 120
    (cd ./enterprise-search ; bash ./KonductorDeploy.sh) 
else
    echo "1ClickECKDeploy.sh: Skipping building entsearch pods due to entsearch_instance_count being 0 or not set."
fi


#add license file
echo "1ClickECKDeploy.sh: Adding trial license"
(cd ./license ; bash ./1ClickAddLicense.sh) 

echo "1ClickECKDeploy.sh: Calling eck/getClusterInfo.sh"
./getClusterInfo.sh
