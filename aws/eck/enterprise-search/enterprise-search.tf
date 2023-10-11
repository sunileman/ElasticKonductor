resource "kubectl_manifest" "enterprise-search" {
    count     = length(data.kubectl_path_documents.enterprise-search-count.documents)
    yaml_body = element(data.kubectl_path_documents.enterprise-search.documents, count.index)
    ignore_fields = ["metadata.annotations"]

    depends_on = [kubernetes_secret.es-credentials]
}