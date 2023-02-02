#!/bin/bash

##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

set +e 
echo "Running custom addons"
(bash ./custom/1ClickAddons.sh)

set -e
echo "Running KSM addon"
(cd ksm; bash ./1ClickAddons.sh)

##option to disable openebs
echo "openebs option: $1"
openebs=$1

if [[ "$1" == "openebs-disabled" ]]; then
    echo "openebs-disabled"
else
    echo "Running OpenEBS addon"
    (cd openebs; bash ./1ClickAddons.sh)

fi
