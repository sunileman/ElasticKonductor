import boto3
import argparse
import hcl2

# Set up argument parsing
parser = argparse.ArgumentParser(description="Apply tags from terraform.tfvars to all instances in an ASG")
parser.add_argument("cluster_name", help="Name of the eks cluster")
args = parser.parse_args()


# Read tags from the terraform.tfvars file
with open("terraform.tfvars", "r") as file:
    tfvars = hcl2.load(file)
    region = tfvars["region"]

# Connect to AWS services
ec2 = boto3.client("ec2", region_name=region)

# Get a list of all EBS volumes
volumes = ec2.describe_volumes()["Volumes"]

# Iterate through each volume
for volume in volumes:
    if "Tags" in volume:
        for tag in volume["Tags"]:
            if tag["Key"] == "KubernetesCluster" and tag["Value"] == args.cluster_name:
                # Delete the volume
                #ec2.delete_volume(VolumeId=volume["VolumeId"])
                print("Deleted EBS volume:", volume["VolumeId"])

