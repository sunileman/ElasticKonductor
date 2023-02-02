#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config
##Name Gen Util for AKS Kibana Load Balancer
#(cd ./namegen; bash ./1ClickNameGen.sh; sh ./set_TF_VAR_lbname.sh)
(cd ./namegen; bash ./1ClickNameGen.sh )

set -e
#copy variables to operator directory
echo "coping variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

##create elastic CRDs and Operator
echo Creating Elastic CRDS and Operator
(cd ./create-operator ; sh ./1ClickECKOperator.sh)


# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan

# apply terraform plan
terraform apply state.tfplan

#add license file
echo "Adding trial license"
./license/1ClickAddLicense.sh

echo Please wait....
sleep 60
./getClusterInfo.sh
