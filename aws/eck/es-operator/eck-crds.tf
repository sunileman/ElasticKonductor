resource "kubectl_manifest" "elastic_crds" {
  for_each  = data.kubectl_file_documents.elastic_crds_doc.manifests
  yaml_body = each.value
}