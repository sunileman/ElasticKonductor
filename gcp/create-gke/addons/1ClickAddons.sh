#!/bin/bash
##terraform logs

echo "Runnig custom addons"
(./1ClickCustomAddons.sh)

##option to disable openebs
echo "openebs option: $1"
openebs=$1

if [[ "$1" == "openebs-disabled" ]]; then
    echo "openebs-disabled"
    echo "Running KSM addon"
    (cd ksm; bash ./1ClickAddons.sh)
else
    echo "Running OpenEBS addon"
    (cd openebs; bash ./1ClickAddons.sh)

    echo "Running KSM addon"
    (cd ksm; bash ./1ClickAddons.sh)
fi
