resource "kubectl_manifest" "ElasticSearch" {
    count     = length(data.kubectl_path_documents.es-count.documents)
    yaml_body = element(data.kubectl_path_documents.es.documents, count.index)
    depends_on = [kubectl_manifest.secrets]
    ignore_fields = ["metadata.annotations"]
}
