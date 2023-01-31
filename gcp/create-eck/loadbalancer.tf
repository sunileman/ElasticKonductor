resource "kubectl_manifest" "loadbalancer" {
    count     = length(data.kubectl_path_documents.loadbalancer-count.documents)
    yaml_body = element(data.kubectl_path_documents.loadbalancer.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
