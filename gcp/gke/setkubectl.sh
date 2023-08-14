#!/bin/bash
set -e
echo "setkubectl.sh: setting local kubectl"
clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw//\"/}
regionraw=$(terraform output region)
region=${regionraw//\"/}

projectraw=$(terraform output gcp_project)
project=${projectraw//\"/}
echo $clustername
echo $region
echo $project
gcloud container clusters get-credentials $clustername --region=$region --project=$project

echo "setkubectl.sh: finished setting local kubectl"
