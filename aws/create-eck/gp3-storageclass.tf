resource "kubectl_manifest" "gp3" {
    count     = length(data.kubectl_path_documents.gp3-count.documents)
    yaml_body = element(data.kubectl_path_documents.gp3.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
