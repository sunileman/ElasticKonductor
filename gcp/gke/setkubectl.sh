#!/bin/bash
set -e
echo "setkubectl.sh: setting local kubectl"
clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw//\"/}
regionraw=$(terraform output region)
region=${regionraw//\"/}
gcpprojectraw=$(terraform output gcp_project)
gcpproject=${gcpprojectraw//\"/}
echo $clustername
echo $region
echo $gcpproject

gcloud container clusters get-credentials $clustername --region=$region --project=$gcpproject
echo "setkubectl.sh: finished setting local kubectl"
