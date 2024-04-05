data "terraform_remote_state" "k8s" {
  backend = "local"

  config = {
    path = "../../aks/terraform.tfstate"
  }
}

data "terraform_remote_state" "namegen" {
  backend = "local"

  config = {
    path = "${path.module}/namegen/terraform.tfstate"
  }
}



data "kubectl_path_documents" "ingest-loadbalancer" {
    pattern = "../eck-yamls/ingest-loadbalancer.yaml"
    vars = {
        eck_namespace = var.eck_namespace
        #lb2name = var.lb2name
        ingestLbName = data.terraform_remote_state.namegen.outputs.ingestLbName
    }
}

data "kubectl_path_documents" "ingest-loadbalancer-count" {
    pattern = "../eck-yamls/ingest-loadbalancer.yaml"
    vars = {
        eck_namespace = ""
        ingestLbName = ""
    }
}


data "kubectl_path_documents" "search-loadbalancer" {
    pattern = "../eck-yamls/search-loadbalancer.yaml"
    vars = {
        eck_namespace = var.eck_namespace
        #lb2name = var.lb2name
        searchLbName = data.terraform_remote_state.namegen.outputs.searchLbName
    }
}

data "kubectl_path_documents" "search-loadbalancer-count" {
    pattern = "../eck-yamls/search-loadbalancer.yaml"
    vars = {
        eck_namespace = ""
        searchLbName = ""
    }
}