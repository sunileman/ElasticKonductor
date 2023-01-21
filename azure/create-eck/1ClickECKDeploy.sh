#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config
##Name Gen Util for AKS Kibana Load Balancer
(cd ./namegen; sh ./1ClickNameGen.sh; sh ./set_TF_VAR_lbname.sh)

#copy variables to operator directory
cp ./variables.tf ./create-operator/
cp ./terraform.tfvars ./create-operator/

##create elastic CRDs and Operator
echo Creating Elastic CRDS and Operator
(cd ./create-operator ; sh ./1ClickECKOperator.sh)

#add license file
./eck-add-license.sh

# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan

# apply terraform plan
terraform apply state.tfplan

echo Please wait....
sleep 60
./getKibanaInfo.sh
