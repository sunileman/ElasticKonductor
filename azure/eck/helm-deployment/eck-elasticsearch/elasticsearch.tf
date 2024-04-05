resource "helm_release" "elasticsearch" {
  name       = "eck-elasticsearch"
  chart      = "eck-elasticsearch"
  version    = var.es_chart_version
  repository = "https://helm.elastic.co"
  namespace  =  var.eck_namespace


  values = [templatefile("${path.module}/eck-yamls/es.yaml", {
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
        master_accept_ingest = var.master_accept_ingest
        hot_accept_ingest = var.hot_accept_ingest
        warm_accept_ingest = var.warm_accept_ingest
        cold_accept_ingest = var.cold_accept_ingest
        frozen_accept_ingest = var.frozen_accept_ingest
        ml_accept_ingest = var.ml_accept_ingest
        master_accept_search = var.master_accept_search
        hot_accept_search = var.hot_accept_search
        warm_accept_search = var.warm_accept_search
        cold_accept_search = var.cold_accept_search
        frozen_accept_search = var.frozen_accept_search
        ml_accept_search = var.ml_accept_search
        master_pod_storage_class = var.master_pod_storage_class
        hot_pod_storage_class = var.hot_pod_storage_class
        warm_pod_storage_class = var.warm_pod_storage_class
        cold_pod_storage_class = var.cold_pod_storage_class
        frozen_pod_storage_class = var.frozen_pod_storage_class
        ml_pod_storage_class = var.ml_pod_storage_class
  })]

}