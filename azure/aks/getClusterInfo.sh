#!/bin/bash
set -e

echo "getClusterInfo.sh parsing...."

## get variables from terraform state
regionraw=$(terraform output region)
region=${regionraw//\"/}

clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw//\"/}

rgname=$(terraform output resource_group_name)
rgname=${rgname//\"/}  # Removes any quotation marks from the 'rgname' variable

# Clear screen for clean output
clear

# Print formatted output
echo "============================================================"
echo "                 CLUSTER AND RESOURCE INFO                   "
echo "============================================================"
printf "\n"

printf "K8s Cluster Name:    %-15s \n" "$clustername"
printf "K8s Region:          %-15s \n" "$region"
printf "Resource Group Name: %-15s \n" "$rgname"
printf "\n"

echo "============================================================"
