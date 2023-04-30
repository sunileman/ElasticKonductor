resource "kubectl_manifest" "warm-sc" {
    count     = var.warm_pod_storage_class == "local-storage" ? 0 :  length(data.kubectl_path_documents.warm-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.warm-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
