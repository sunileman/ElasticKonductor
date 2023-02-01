#!/bin/bash
##area to run custom commands before other addons are created

echo "adding cluster-admin-binding, if it fails due to role already exists thats okay"
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")
