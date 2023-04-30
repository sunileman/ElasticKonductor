resource "kubectl_manifest" "hot-sc" {
    count     = var.hot_pod_storage_class == "local-storage" ? 0 : length(data.kubectl_path_documents.hot-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.hot-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
