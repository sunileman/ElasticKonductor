#!/bin/bash

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

set -e

echo "1ClickGKEDeploy.sh: Building Node Pool one at a time"

echo "1ClickGKEDeploy.sh: Building master node pool"
(cd ./master; bash ./1ClickGKEMasterDeploy.sh)


echo "1ClickGKEDeploy.sh: Building kibana node pool"
(cd ./kibana; bash ./1ClickGKEKibanaDeploy.sh)


echo "1ClickGKEDeploy.sh: Building hot node pool"
(cd ./hot; bash ./1ClickGKEHotDeploy.sh)


echo "1ClickGKEDeploy.sh: Building warm node pool"
(cd ./warm; bash ./1ClickGKEWarmDeploy.sh)


echo "1ClickGKEDeploy.sh: Building cold node pool"
(cd ./cold; bash ./1ClickGKEColdDeploy.sh)


echo "1ClickGKEDeploy.sh: Building frozen node pool"
(cd ./frozen; bash ./1ClickGKEFrozenDeploy.sh)


echo "1ClickGKEDeploy.sh: Building ml node pool"
(cd ./ml; bash ./1ClickGKEMLDeploy.sh)

echo "1ClickGKEDeploy.sh: Building logstash node pool"
(cd ./logstash; bash ./1ClickGKELogStashDeploy.sh)

echo "1ClickGKEDeploy.sh: Building util node pool"
(cd ./util; bash ./1ClickGKEUtilDeploy.sh)


echo "1ClickGKEDeploy.sh: Building otel node pool"
(cd ./otel; bash ./1ClickGKEOtelDeploy.sh)
