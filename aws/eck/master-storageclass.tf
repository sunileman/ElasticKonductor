resource "kubectl_manifest" "master-sc" {
    count     = length(data.kubectl_path_documents.master-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.master-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
