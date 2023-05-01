resource "kubectl_manifest" "frozen-io2-be" {
    count     = var.frozen_pod_storage_class == "frozen-io2-be" ? length(data.kubectl_path_documents.frozen-io2-be-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.frozen-io2-be.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}