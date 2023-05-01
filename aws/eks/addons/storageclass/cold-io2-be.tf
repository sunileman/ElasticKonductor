resource "kubectl_manifest" "cold-io2-be" {
    count     = var.cold_pod_storage_class == "cold-io2-be" ? length(data.kubectl_path_documents.cold-io2-be-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.cold-io2-be.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}