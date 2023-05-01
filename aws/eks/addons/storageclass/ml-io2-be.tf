resource "kubectl_manifest" "ml-io2-be" {
    count     = var.ml_pod_storage_class == "ml-io2-be" ? length(data.kubectl_path_documents.ml-io2-be-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.ml-io2-be.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}