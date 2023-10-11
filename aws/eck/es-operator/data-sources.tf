data "terraform_remote_state" "k8s" {
  backend = "local"

  config = {
    path = "../../eks/terraform.tfstate"
  }
}


data "curl" "elastic_crds" {
  http_method = "GET"
  uri = "https://download.elastic.co/downloads/eck/${var.eck_version}/crds.yaml"
}

data "kubectl_file_documents" "elastic_crds_doc" {
  content = data.curl.elastic_crds.response
}
