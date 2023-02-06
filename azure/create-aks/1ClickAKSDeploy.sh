#!/bin/bash
##terraform log
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

##option to disable openebs
echo "1ClickAKSDeploy.sh: openebs option: $1"
openebs=$1


export KUBE_CONFIG_PATH=~/.kube/config
set -e

echo "1ClickAKSDeploy.sh: coping variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .

echo "1ClickAKSDeploy.sh: creating AKS"
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan

# apply terraform plan
terraform apply state.tfplan
echo "1ClickAKSDeploy.sh: finished coping variable files"


echo "1ClickAKSDeploy.sh: calling setkubectl.sh"
bash ./setkubectl.sh

echo "1ClickAKSDeploy.sh: calling setDataSourceRG.sh"
bash ./setDataSourceRG.sh

echo "1ClickAKSDeploy.sh: Running addons"
(cd ./addons; bash ./1ClickAddons.sh $openebs)

# cleanup
#terraform destroy -auto-approve
