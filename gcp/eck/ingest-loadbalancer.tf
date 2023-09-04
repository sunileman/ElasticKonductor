resource "kubectl_manifest" "ingest-loadbalancer" {
    count     = length(data.kubectl_path_documents.ingest-loadbalancer-count.documents)
    yaml_body = element(data.kubectl_path_documents.ingest-loadbalancer.documents, count.index)
    ignore_fields = ["metadata.annotations"]
}
