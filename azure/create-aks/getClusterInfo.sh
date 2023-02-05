#!/bin/bash
set -e
echo "getClusterInfo.sh: parsing region and cluster name"
##get variables from terraform state
regionraw=$(terraform output region)
region=${regionraw:1: -1}
clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw:1: -1}


echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "K8s Cluster Name: $clustername"
echo "K8s Region: $region"
echo
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
