#!/bin/bash

clusternameraw=$(terraform output cluster_name)
clustername=${clusternameraw:1: -1}
regionraw=$(terraform output region)
region=${regionraw:1: -1}
echo $clustername
echo $region
gcloud container clusters get-credentials $clustername --region=$region
