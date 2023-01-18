resource "kubectl_manifest" "ElasticSearch" {
    for_each  = toset(data.kubectl_path_documents.es.documents)
    yaml_body = each.value
    depends_on = [kubectl_manifest.iscsi, helm_release.openebs]
}
