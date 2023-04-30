resource "kubectl_manifest" "frozen-sc" {
    count     = var.frozen_pod_storage_class == "local-storage" ? 0 :  length(data.kubectl_path_documents.frozen-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.frozen-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
