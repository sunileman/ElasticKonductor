#!/bin/bash

echo "setkubectl.sh: setting local kubectl"
clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw//\"/}
regionraw=$(terraform output region)
region=${regionraw//\"/}
echo $clustername
echo $region

aws eks --region $region update-kubeconfig --name $clustername

echo "setkubectl.sh: finished setting local kubectl"
