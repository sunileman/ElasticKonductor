#!/bin/bash
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"
export KUBE_CONFIG_PATH=~/.kube/config


set +e 
echo "1ClickAddons.sh: Running custom addons"
(bash ./custom/1ClickAddons.sh)
set -e 


echo "1ClickAddons.sh :Running KSM addon"
(cd ksm; bash ./1ClickAddons.sh)

echo "1ClickAddons.sh: Running autoscaler addon"
(cd autoscaler; bash ./1ClickAddons.sh)

echo "1ClickAddons.sh: Running iscsi addon"
(cd iscsi; bash ./1ClickAddons.sh)

#echo "1ClickAddons.sh: Running istio addon"
#(cd istio; bash ./1ClickAddons.sh)

##option to disable openebs
echo "1ClickAddons.sh: openebs option: $1"
openebs=$1

if [[ "$1" == "openebs-disabled" ]]; then
    echo "1ClickAddons.sh: openebs-disabled"
    echo "1ClickAddons.sh: Running Destroy OpenEBS addon"
    (cd openebs; bash ./1ClickAddonsDestroy.sh)
else
    echo "1ClickAddons.sh: Running OpenEBS addon"
    set +e
    (cd openebs; bash ./1ClickAddons.sh)
    set -e

fi


echo "1ClickAddons.sh: Running storageclass addon"
(cd storageclass; bash ./1ClickAddons.sh)