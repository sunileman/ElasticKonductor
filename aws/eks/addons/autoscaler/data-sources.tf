data "terraform_remote_state" "k8s" {
  backend = "local"

  config = {
    path = "../../terraform.tfstate"
  }
}

data "kubectl_path_documents" "autoscaler" {
    pattern = "${path.module}/yamls/autoscaler.yaml"
    vars = {
      clustername = data.terraform_remote_state.k8s.outputs.cluster_name 
    }
    
}
