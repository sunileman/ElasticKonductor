resource "kubectl_manifest" "master-io2-be" {
    count     = var.master_pod_storage_class == "master-io2-be" ? length(data.kubectl_path_documents.master-io2-be-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.master-io2-be.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}