#!/bin/bash
set -e
echo "$(terraform output kube_config)" > ~/.kube/config; sed -i '$ d' ~/.kube/config; sed -i '1,1d' ~/.kube/config
