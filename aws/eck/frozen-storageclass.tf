resource "kubectl_manifest" "frozen-sc" {
    count     = length(data.kubectl_path_documents.frozen-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.frozen-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
