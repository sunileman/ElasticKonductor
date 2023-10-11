#!/bin/bash

# Check if VPC ID is provided as an argument
if [ -z "$1" ]; then
    echo "Please provide a VPC ID as an argument."
    exit 1
fi

# VPC ID from the argument
VPC_ID=$1


# 2. Delete network interfaces
ENIS=$(aws ec2 describe-network-interfaces --filters "Name=vpc-id,Values=$VPC_ID" | jq -r '.NetworkInterfaces[] | select(any(.Groups[]; .GroupName | startswith("GuardDutyManagedSecurityGroup"))) | .NetworkInterfaceId')


# Output the security group IDs
echo "Network interfaces to be deleted: $ENIS"


for ENI in $ENIS; do
    aws ec2 delete-network-interface --network-interface-id $ENI
    while aws ec2 describe-network-interfaces --network-interface-ids $ENI &> /dev/null; do
        echo "Waiting for network interface $ENI to be deleted..."
        sleep 10
    done
    echo "Network interface $ENI deleted."
done