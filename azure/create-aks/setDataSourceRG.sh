#!/bin/bash
set -e
var1=$(terraform output resource_group_name)
sed -i "s/resource_group_name=.*/resource_group_name=$var1/g" ../create-eck/data-sources.tf
