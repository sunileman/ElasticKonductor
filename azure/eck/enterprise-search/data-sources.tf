data "external" "k8s_secret" {
  program = ["${path.module}/get_secret.sh"]
}


data "kubectl_path_documents" "enterprise-search" {
    pattern = "./enterprise-search.yaml"
    vars = {
        eck_namespace = var.eck_namespace
    }
}


data "kubectl_path_documents" "enterprise-search-count" {
    pattern = "./enterprise-search.yaml"
    vars = {
        eck_namespace = ""
    }
}