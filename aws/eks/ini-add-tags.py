import boto3
import argparse
import hcl2
from datetime import datetime


# Set up argument parsing
parser = argparse.ArgumentParser(description="Apply tags from terraform.tfvars to all instances in an ASG")
parser.add_argument("asg_name", help="Name of the Auto Scaling Group")
args = parser.parse_args()

# Read tags from the terraform.tfvars file
with open("terraform.tfvars", "r") as file:
    tfvars = hcl2.load(file)
    tags = tfvars["tags"]

# Add the "createdate" tag
tags["createdate"] = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Connect to AWS services
ec2 = boto3.resource("ec2")
autoscaling = boto3.client("autoscaling")

# Get instances in the ASG
response = autoscaling.describe_auto_scaling_groups(AutoScalingGroupNames=[args.asg_name])
instance_ids = [instance["InstanceId"] for instance in response["AutoScalingGroups"][0]["Instances"]]

# Apply the tags to each instance
for instance_id in instance_ids:
    ec2_instance = ec2.Instance(instance_id)
    for key, value in tags.items():
        ec2_instance.create_tags(Tags=[{"Key": key, "Value": value}])
