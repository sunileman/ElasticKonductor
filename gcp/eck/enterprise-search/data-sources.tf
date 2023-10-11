data "external" "k8s_secret" {
  program = ["${path.module}/get_secret.sh"]
}


data "kubectl_path_documents" "enterprise-search" {
    pattern = "./enterprise-search.yaml"
    vars = {
        eck_namespace = var.eck_namespace
        es_version = var.es_version
        entsearch_pod_memory = var.entsearch_pod_memory
        entsearch_pod_cpu = var.entsearch_pod_cpu
        entsearch_pod_count = var.entsearch_pod_count
        entsearch_accept_ingest = var.entsearch_accept_ingest
        entsearch_accept_search = var.entsearch_accept_search
        entsearch_pod_ES_JAVA_OPTS = var.entsearch_pod_ES_JAVA_OPTS

    }
}


data "kubectl_path_documents" "enterprise-search-count" {
    pattern = "./enterprise-search.yaml"
    vars = {
        eck_namespace = ""
        es_version = ""
        entsearch_pod_memory = ""
        entsearch_pod_cpu = ""
        entsearch_pod_count = ""
        entsearch_accept_ingest = ""
        entsearch_accept_search = ""
        entsearch_pod_ES_JAVA_OPTS = ""
    }
}