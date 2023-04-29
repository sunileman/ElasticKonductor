resource "kubectl_manifest" "warm-sc" {
    count     = length(data.kubectl_path_documents.warm-sc-count.documents)
    yaml_body = element(data.kubectl_path_documents.warm-sc.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
