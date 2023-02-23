#!/bin/bash
set -e
echo getClusterInfo.sh: Getting cluster info
(cd ./eck; ./getClusterInfo.sh)
