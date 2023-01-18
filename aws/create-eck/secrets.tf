resource "kubectl_manifest" "secrets" {
    for_each  = toset(data.kubectl_path_documents.aws-secrets.documents)
    yaml_body = each.value
}
