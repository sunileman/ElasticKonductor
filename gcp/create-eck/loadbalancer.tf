resource "kubectl_manifest" "loadbalancer" {
    for_each  = toset(data.kubectl_path_documents.loadbalancer.documents)
    yaml_body = each.value
}
