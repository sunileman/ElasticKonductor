#!/bin/bash

# Check if VPC ID is provided as an argument
if [ -z "$1" ]; then
    echo "Please provide a VPC ID as an argument."
    exit 1
fi

# VPC ID from the argument
VPC_ID=$1

# 1. Delete VPC endpoints
VPCE_ENDPOINTS=$(aws ec2 describe-vpc-endpoints --filters "Name=vpc-id,Values=$VPC_ID" "Name=service-name,Values=com.amazonaws.us-east-1.guardduty-data" --query "VpcEndpoints[*].VpcEndpointId" --output text)

# Output the security group IDs
echo "VPC endpoints to be deleted: $VPCE_ENDPOINTS"



for ENDPOINT in $VPCE_ENDPOINTS; do
    aws ec2 delete-vpc-endpoints --vpc-endpoint-ids $ENDPOINT
    while aws ec2 describe-vpc-endpoints --vpc-endpoint-ids $ENDPOINT &> /dev/null; do
        echo "Waiting for VPC endpoint $ENDPOINT to be deleted..."
        sleep 10
    done
    echo "VPC endpoint $ENDPOINT deleted."
done