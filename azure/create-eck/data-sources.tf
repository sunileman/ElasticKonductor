data "terraform_remote_state" "k8s" {
  backend = "local"

  config = {
    path = "../create-aks/terraform.tfstate"
  }
}

data "terraform_remote_state" "namegen" {
  backend = "local"

  config = {
    path = "${path.module}/namegen/terraform.tfstate"
  }
}


data "curl" "iscsi" {
  http_method = "GET"
  uri = "https://raw.githubusercontent.com/longhorn/longhorn/v1.4.0/deploy/prerequisite/longhorn-iscsi-installation.yaml"
}

data "kubectl_file_documents" "iscsi_doc" {
  content = data.curl.iscsi.response
}


data "kubectl_path_documents" "es" {
    pattern = "./eck-yamls/es.yaml"
    vars = {
        es_version = var.es_version
        eck_namespace = var.eck_namespace
        master_pod_ES_JAVA_OPTS = var.master_pod_ES_JAVA_OPTS
        hot_pod_ES_JAVA_OPTS = var.hot_pod_ES_JAVA_OPTS
        warm_pod_ES_JAVA_OPTS = var.warm_pod_ES_JAVA_OPTS
        cold_pod_ES_JAVA_OPTS = var.cold_pod_ES_JAVA_OPTS
        frozen_pod_ES_JAVA_OPTS = var.frozen_pod_ES_JAVA_OPTS
        ml_pod_ES_JAVA_OPTS = var.ml_pod_ES_JAVA_OPTS
        master_pod_roles = var.master_pod_roles
        hot_pod_roles = var.hot_pod_roles
        warm_pod_roles = var.warm_pod_roles
        cold_pod_roles = var.cold_pod_roles
        frozen_pod_roles = var.frozen_pod_roles
        ml_pod_roles = var.ml_pod_roles
        master_pod_cpu = var.master_pod_cpu
        hot_pod_cpu = var.hot_pod_cpu
        warm_pod_cpu = var.warm_pod_cpu
        cold_pod_cpu = var.cold_pod_cpu
        frozen_pod_cpu = var.frozen_pod_cpu
        ml_pod_cpu = var.ml_pod_cpu
        master_pod_memory = var.master_pod_memory
        hot_pod_memory = var.hot_pod_memory
        warm_pod_memory = var.warm_pod_memory
        cold_pod_memory = var.cold_pod_memory
        frozen_pod_memory = var.frozen_pod_memory
        ml_pod_memory = var.ml_pod_memory
        master_pod_count = var.master_pod_count
        hot_pod_count = var.hot_pod_count
        warm_pod_count = var.warm_pod_count
        cold_pod_count = var.cold_pod_count
        frozen_pod_count = var.frozen_pod_count
        ml_pod_count = var.ml_pod_count
        master_pod_storage = var.master_pod_storage
        hot_pod_storage = var.hot_pod_storage
        warm_pod_storage = var.warm_pod_storage
        cold_pod_storage = var.cold_pod_storage
        frozen_pod_storage = var.frozen_pod_storage
        ml_pod_storage = var.ml_pod_storage
    }
}



data "kubectl_path_documents" "kibana" {
    pattern = "./eck-yamls/kibana.yaml"
    vars = {
        es_version = var.es_version
        eck_namespace = var.eck_namespace
        kibana_pod_memory = var.kibana_pod_memory
        kibana_pod_cpu = var.kibana_pod_cpu
        kibana_pod_count = var.kibana_pod_count
        #lbname = var.lbname
        lbname = data.terraform_remote_state.namegen.outputs.lbname
    }
}


data "kubectl_path_documents" "loadbalancer" {
    pattern = "./eck-yamls/loadbalancer.yaml"
    vars = {
        eck_namespace = var.eck_namespace
        #lb2name = var.lb2name
        lb2name = data.terraform_remote_state.namegen.outputs.lb2name
    }
}


