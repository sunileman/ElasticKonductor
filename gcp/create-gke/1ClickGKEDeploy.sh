#!/bin/bash

##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

##option to disable openebs
echo "1ClickGKEDeploy.sh: openebs option: $1"
openebs=$1


export KUBE_CONFIG_PATH=~/.kube/config
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

set -e
echo "1ClickGKEDeploy.sh: Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

echo "1ClickGKEDeploy.sh: Building GKE Infra"
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan 

# apply terraform plan
terraform apply state.tfplan

##creating worker node pools
(cd ./gke-workers; bash ./1ClickGKEWorkersDeploy.sh)

echo "1ClickGKEDeploy.sh: setting local kube config"
(bash ./setkubectl.sh)

echo "1ClickGKEDeploy.sh: Running addons"
(cd addons; bash ./1ClickAddons.sh $openebs)

