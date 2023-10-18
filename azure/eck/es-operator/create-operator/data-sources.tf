data "terraform_remote_state" "parent_state" {
  backend = "local" # This is an example, adjust based on where your state is stored

  config = {
    path = "../terraform.tfstate" # Adjust the path to point to your parent module's state file
  }
}

