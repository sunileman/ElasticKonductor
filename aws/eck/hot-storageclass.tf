resource "kubectl_manifest" "hot-sc" {
    count     = length(data.kubectl_path_documents.hot-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.hot-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
