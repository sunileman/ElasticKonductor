resource "kubectl_manifest" "search-loadbalancer" {
    count     = length(data.kubectl_path_documents.search-loadbalancer-count.documents)
    yaml_body = element(data.kubectl_path_documents.search-loadbalancer.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
