data "terraform_remote_state" "k8s" {
  backend = "local"

  config = {
    path = "../terraform.tfstate"
  }
}


data "curl" "iscsi" {
  http_method = "GET"
  uri = "https://raw.githubusercontent.com/longhorn/longhorn/v1.4.0/deploy/prerequisite/longhorn-iscsi-installation.yaml"
}

data "kubectl_file_documents" "iscsi_doc" {
  content = data.curl.iscsi.response
}


data "kubectl_path_documents" "autoscaler" {
    pattern = "${path.module}/yamls/autoscaler.yaml"
    vars = {
      clustername = data.terraform_remote_state.k8s.outputs.cluster_name 
    }
    
}
