resource "kubectl_manifest" "warm-gp3" {
    count     = var.warm_pod_storage_class == "warm-gp3" ? length(data.kubectl_path_documents.warm-gp3-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.warm-gp3.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
