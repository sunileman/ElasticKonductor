#!/bin/bash

##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"
export KUBE_CONFIG_PATH=~/.kube/config

echo "1ClickAddons.sh: Running Destroy custom addon"
(cd ./custom; bash ./1ClickAddonsDestroy.sh)
echo "1ClickAddons.sh: Finished running custom addons"


echo "1ClickAddons.sh: Running Destroy autosacler addon"
(cd ./autoscaler; bash ./1ClickAddonsDestroy.sh)
echo "1ClickAddons.sh: Finished running custom addon"


echo "1ClickAddons.sh: Running Destroy KSM addon"
(cd ksm; bash ./1ClickAddonsDestroy.sh)

echo "1ClickAddons.sh: Running Destroy iscsi addon"
(cd iscsi; bash ./1ClickAddonsDestroy.sh)

echo "1ClickAddons.sh: Running Destroy OpenEBS addon"
(cd openebs; bash ./1ClickAddonsDestroy.sh)

