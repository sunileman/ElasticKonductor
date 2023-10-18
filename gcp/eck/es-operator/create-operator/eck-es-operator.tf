resource "kubectl_manifest" "elastic_operator_doc" {
  for_each  = data.terraform_remote_state.parent_state.outputs.elastic_operator_doc_manifests
  yaml_body = each.value
}