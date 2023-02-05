#!/bin/bash

echo "1ClickGKEDestroy.sh: Building master node pool"
(cd ./master; bash ./1ClickGKEMasterDestroy.sh)

echo "1ClickGKEDestroy.sh: Building kibana node pool"
(cd ./kibana; bash ./1ClickGKEKibanaDestroy.sh)

echo "1ClickGKEDestroy.sh: Building hot node pool"
(cd ./hot; bash ./1ClickGKEHotDestroy.sh)

echo "1ClickGKEDestroy.sh: Building warm node pool"
(cd ./warm; bash ./1ClickGKEWarmDestroy.sh)

echo "1ClickGKEDestroy.sh: Building cold node pool"
(cd ./cold; bash ./1ClickGKEColdDestroy.sh)

echo "1ClickGKEDestroy.sh: Building frozen node pool"
(cd ./frozen; bash ./1ClickGKEFrozenDestroy.sh)

echo "1ClickGKEDestroy.sh: Building ml node pool"
(cd ./ml; bash ./1ClickGKEMLDestroy.sh)

echo "1ClickGKEDestroy.sh: Building util node pool"
(cd ./util; bash ./1ClickGKEUtilDestroy.sh)
