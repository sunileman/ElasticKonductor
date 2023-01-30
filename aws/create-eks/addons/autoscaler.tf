resource "kubectl_manifest" "autoscaler" {
  for_each  = toset(data.kubectl_path_documents.autoscaler.documents)
  yaml_body = each.value
}
