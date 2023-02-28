#!/bin/bash

##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"
export KUBE_CONFIG_PATH=~/.kube/config

echo "1ClickAddons.sh: Running Destroy custom addons"
(cd ./custom; bash ./ClickAddonsDestroy.sh)
echo "1ClickAddons.sh: Finished running custom addons"


echo "1ClickAddons.sh: Running Destroy KSM addon"
(cd ksm; bash ./1ClickAddonsDestroy.sh)
echo "1ClickAddons.sh: Finished running KSM addon"


echo "1ClickAddons.sh: Running Destroy iscsi addon"
(cd iscsi; bash ./1ClickAddonsDestroy.sh)

echo "1ClickAddons.sh: Running Destroy OpenEBS addon"
(cd openebs; bash ./1ClickAddonsDestroy.sh)

