data "terraform_remote_state" "k8s" {
  backend = "local"

  config = {
    path = "../../../aks/terraform.tfstate"
  }
}

data "terraform_remote_state" "namegen" {
  backend = "local"

  config = {
    path = "../../loadbalancers/namegen/terraform.tfstate"
  }
}

