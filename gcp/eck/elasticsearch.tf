resource "kubectl_manifest" "ElasticSearch" {
    count     = length(data.kubectl_path_documents.es-count.documents)
    yaml_body = element(data.kubectl_path_documents.es.documents, count.index)
}
