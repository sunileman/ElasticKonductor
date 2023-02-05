#!/bin/bash
set -e
echo getClusterInfo.sh: Getting cluster info
(cd ./create-eck; ./getClusterInfo.sh)
