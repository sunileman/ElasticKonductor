resource "kubectl_manifest" "frozen-gp3" {
    count     = var.frozen_pod_storage_class == "frozen-gp3" ? length(data.kubectl_path_documents.frozen-gp3-count.documents) : 0
    yaml_body = element(data.kubectl_path_documents.frozen-gp3.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}