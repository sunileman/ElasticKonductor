resource "kubectl_manifest" "kibana" {
    for_each  = toset(data.kubectl_path_documents.kibana.documents)
    yaml_body = each.value
}
