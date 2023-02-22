#!/bin/bash
set -e

echo "1ClickNameGen.sh: generating name"
# initialize terraform configuration
terraform init

# validate terraform configuration
terraform validate

# create terraform plan
terraform plan -out state.tfplan

# apply terraform plan
terraform apply state.tfplan
