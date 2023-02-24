resource "kubectl_manifest" "kibana" {
    count     = length(data.kubectl_path_documents.kibana-count.documents)
    yaml_body = element(data.kubectl_path_documents.kibana.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
