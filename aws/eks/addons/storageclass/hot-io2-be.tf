resource "kubectl_manifest" "hot-io2-be" {
    count     = var.hot_pod_storage_class == "hot-io2-be" ? length(data.kubectl_path_documents.hot-io2-be-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.hot-io2-be.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}