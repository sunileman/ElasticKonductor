#!/bin/bash

# Check if VPC ID is provided as an argument
if [ -z "$1" ]; then
    echo "Please provide a VPC ID as an argument."
    exit 1
fi

# VPC ID from the argument
VPC_ID=$1


# 3. Delete security groups
SECURITY_GROUP_IDS=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=GuardDutyManagedSecurityGroup*" --query "SecurityGroups[*].GroupId" --output text)

# Output the security group IDs
echo "Security group IDs to be deleted: $SECURITY_GROUP_IDS" 


for SG_ID in $SECURITY_GROUP_IDS; do
    aws ec2 delete-security-group --group-id $SG_ID
    while aws ec2 describe-security-groups --group-ids $SG_ID &> /dev/null; do
        echo "Waiting for security group $SG_ID to be deleted..."
        sleep 10
    done
    echo "Security group $SG_ID deleted."
done

echo "All tasks completed."
