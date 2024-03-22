#!/bin/bash

# Set the namespace
NAMESPACE="openebs"

# Get the list of BlockDevice names
BDS=$(kubectl get bd -n ${NAMESPACE} -o jsonpath='{.items[*].metadata.name}')

# Loop through each BlockDevice and remove the finalizer
for BD in $BDS; do
    echo "Removing finalizer from BlockDevice $BD"
    kubectl patch bd $BD -n ${NAMESPACE} --type='json' -p='[{"op": "remove", "path": "/metadata/finalizers"}]'
done

# Wait for a moment to ensure the patch commands are executed
sleep 5

# Delete all BlockDevices in the namespace
echo "Deleting all BlockDevices in namespace ${NAMESPACE}"
kubectl delete bd --all -n ${NAMESPACE} --force --grace-period=0

# Get the list of BlockDeviceClaim names
BDCS=$(kubectl get bdc -n ${NAMESPACE} -o jsonpath='{.items[*].metadata.name}')

# Loop through each BlockDeviceClaim and remove the finalizer (if you expect them to have finalizers)
for BDC in $BDCS; do
    echo "Removing finalizer from BlockDeviceClaim $BDC"
    kubectl patch bdc $BDC -n ${NAMESPACE} --type='json' -p='[{"op": "remove", "path": "/metadata/finalizers"}]'
done

# Wait for a moment to ensure the patch commands are executed
sleep 5

# Delete all BlockDeviceClaims in the namespace
echo "Deleting all BlockDeviceClaims in namespace ${NAMESPACE}"
kubectl delete bdc --all -n ${NAMESPACE} --force --grace-period=0

# Verify deletion of BlockDevices and BlockDeviceClaims
echo "Verifying that all BlockDevices are deleted"
BDS=$(kubectl get bd -n ${NAMESPACE} -o name)
if [ -z "$BDS" ]; then
    echo "No BlockDevices found."
else
    echo "Remaining BlockDevices:"
    echo "$BDS"
fi

echo "Verifying that all BlockDeviceClaims are deleted"
BDCS=$(kubectl get bdc -n ${NAMESPACE} -o name)
if [ -z "$BDCS" ]; then
    echo "No BlockDeviceClaims found."
else
    echo "Remaining BlockDeviceClaims:"
    echo "$BDCS"
fi

