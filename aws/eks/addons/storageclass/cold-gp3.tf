resource "kubectl_manifest" "cold-gp3" {
    count     = var.cold_pod_storage_class == "cold-gp3" ? length(data.kubectl_path_documents.cold-gp3-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.cold-gp3.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
