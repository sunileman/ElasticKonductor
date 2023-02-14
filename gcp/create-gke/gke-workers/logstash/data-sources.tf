data "terraform_remote_state" "k8s" {
  backend = "local"

  config = {
    path = "../../terraform.tfstate"
  }
}
