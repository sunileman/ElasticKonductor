resource "kubectl_manifest" "master-gp3" {
    count     = var.master_pod_storage_class == "master-gp3" ? length(data.kubectl_path_documents.master-gp3-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.master-gp3.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
