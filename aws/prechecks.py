import sys
import hcl2



# Read tags.project from the terraform.tfvars file
with open("terraform.tfvars", "r") as file:
    tfvars = hcl2.load(file)
    tags = tfvars["tags"]
    project = tags["project"]

    # Check the value of the "project" variable
    if project == "username":
        print("Bad project name, update terraform.tfvars file tags.project with a project name.  username is not valid")
        sys.exit(1)
    else:
        # Print the contents of the "project" variable
        print(project+" project name is valid")
        sys.exit(0)


