#!/bin/bash
echo Terraform Destroy
terraform destroy -auto-approve
sleep 5
echo Deleting storage handler
kubectl delete -f ./eck-yamls/baremetal-default-storage.yaml 2>/dev/null
sleep 5
echo Deleting operator
kubectl delete -f ./eck-yamls/operator.yaml 2>/dev/null
sleep 5
echo Deleting CRDs
kubectl delete -f https://download.elastic.co/downloads/eck/2.5.0/crds.yaml 2>/dev/null
