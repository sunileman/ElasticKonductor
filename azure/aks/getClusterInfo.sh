#!/bin/bash
set -e
echo "getClusterInfo.sh parsing...."
##get variables from terraform state
regionraw=$(terraform output region)
region=${regionraw//\"/}
clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw//\"/}
rgname=$(terraform output resource_group_name)


echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "K8s Cluster Name: $clustername"
echo "K8s Region: $region"
echo "Resource group name: $rgname"
echo
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~