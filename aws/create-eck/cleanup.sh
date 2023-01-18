#!/bin/bash
echo Terraform Destroy
(cd ./create-operator ; terraform destroy -auto-approve 2>/dev/null)
terraform destroy -auto-approve 2>/dev/null
