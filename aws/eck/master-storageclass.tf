resource "kubectl_manifest" "master-sc" {
    count     = var.master_pod_storage_class == "local-storage" ? 0 :  length(data.kubectl_path_documents.master-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.master-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
