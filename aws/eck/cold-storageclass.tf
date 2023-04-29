resource "kubectl_manifest" "cold-sc" {
    count     = length(data.kubectl_path_documents.cold-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.cold-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
