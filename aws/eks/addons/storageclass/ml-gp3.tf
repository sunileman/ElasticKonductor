resource "kubectl_manifest" "ml-gp3" {
    count     = var.ml_pod_storage_class == "ml-gp3" ? length(data.kubectl_path_documents.ml-gp3-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.ml-gp3.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
