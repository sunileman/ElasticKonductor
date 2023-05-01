resource "kubectl_manifest" "warm-io2-be" {
    count     = var.warm_pod_storage_class == "warm-io2-be" ? length(data.kubectl_path_documents.warm-io2-be-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.warm-io2-be.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}