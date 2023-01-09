resource "kubectl_manifest" "elsatic_operator" {
  for_each  = data.kubectl_file_documents.elastic_operator_doc.manifests
  yaml_body = each.value
  depends_on = [kubectl_manifest.elsatic_crds]
}
