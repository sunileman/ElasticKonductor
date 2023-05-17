#!/bin/bash

##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"
export KUBE_CONFIG_PATH=~/.kube/config

echo "1ClickAddonsDestroy: Running Destroy custom addon"
(cd ./custom; bash ./1ClickAddonsDestroy.sh)
echo "1ClickAddonsDestroy: Finished running custom addons"


echo "1ClickAddonsDestroy: Running Destroy autosacler addon"
(cd ./autoscaler; bash ./1ClickAddonsDestroy.sh)
echo "1ClickAddonsDestroy: Finished running custom addon"


echo "1ClickAddonsDestroy: Running Destroy KSM addon"
(cd ksm; bash ./1ClickAddonsDestroy.sh)

echo "1ClickAddonsDestroy: Running Destroy iscsi addon"
(cd iscsi; bash ./1ClickAddonsDestroy.sh)

echo "1ClickAddonsDestroy: Running Destroy istio addon"
(cd istio; bash ./1ClickAddonsDestroy.sh)

echo "1ClickAddonsDestroy: Running Destroy OpenEBS addon"
(cd openebs; bash ./1ClickAddonsDestroy.sh)

echo "1ClickAddonsDestroy: Running Destroy storageclass addon"
(cd storageclass; bash ./1ClickAddonsDestroy.sh)