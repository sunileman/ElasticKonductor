#!/bin/bash

echo "1ClickGKEDestroy.sh: destroying master node pool"
(cd ./master; bash ./1ClickGKEMasterDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying kibana node pool"
(cd ./kibana; bash ./1ClickGKEKibanaDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying hot node pool"
(cd ./hot; bash ./1ClickGKEHotDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying warm node pool"
(cd ./warm; bash ./1ClickGKEWarmDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying cold node pool"
(cd ./cold; bash ./1ClickGKEColdDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying frozen node pool"
(cd ./frozen; bash ./1ClickGKEFrozenDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying ml node pool"
(cd ./ml; bash ./1ClickGKEMLDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying fleet node pool"
(cd ./fleet; bash ./1ClickGKEFleetDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying enterprise search node pool"
(cd ./enterprise-search; bash ./1ClickGKEEntSearchDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying logstash node pool"
(cd ./logstash; bash ./1ClickGKELogStashDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying util node pool"
(cd ./util; bash ./1ClickGKEUtilDestroy.sh)

echo "1ClickGKEDestroy.sh: destroying otel node pool"
(cd ./otel; bash ./1ClickGKEOtelDestroy.sh)
