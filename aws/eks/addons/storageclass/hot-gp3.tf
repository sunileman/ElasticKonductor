resource "kubectl_manifest" "hot-gp3" {
    count     = var.hot_pod_storage_class == "hot-gp3" ? length(data.kubectl_path_documents.hot-gp3-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.hot-gp3.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}