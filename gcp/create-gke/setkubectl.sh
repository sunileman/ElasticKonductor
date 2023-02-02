#!/bin/bash
set -e
clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw//\"/}
regionraw=$(terraform output region)
region=${regionraw//\"/}
echo $clustername
echo $region
gcloud container clusters get-credentials $clustername --region=$region
