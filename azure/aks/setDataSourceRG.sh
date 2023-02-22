#!/bin/bash
set -e
echo "setDataSourceRG.sh: getting resource group name"
var1=$(terraform output resource_group_name)
echo "setDataSourceRG.sh: parsing resource group name"
sed -i "s/resource_group_name=.*/resource_group_name=$var1/g" ../eck/data-sources.tf
