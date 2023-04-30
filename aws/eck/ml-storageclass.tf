resource "kubectl_manifest" "ml-sc" {
    count     = var.ml_pod_storage_class == "local-storage" ? 0 :  length(data.kubectl_path_documents.ml-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.ml-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
