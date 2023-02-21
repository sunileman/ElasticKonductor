#!/bin/bash
set -e
echo "setkubectl.sh: setting local kubeclt"
clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw//\"/}
rg_raw=$(terraform output resource_group_name)
rg=${rg_raw//\"/}
echo $clustername
echo $rg

az aks get-credentials --resource-group $rg --name $clustername