#!/bin/bash
echo Checking if license file is exists
echo ...
echo ...
if test -f ./license/es-license.json; then
  echo license file found
  kubectl create secret generic eck-license --from-file=./license/es-license.json -n elastic-system
  kubectl label secret eck-license "license.k8s.elastic.co/scope"=operator -n elastic-system
else
  echo no license file found. Make sure it is named es-license.json
fi
