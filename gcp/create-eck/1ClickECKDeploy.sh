#!/bin/bash

echo "Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

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
./getClusterInfo.sh
