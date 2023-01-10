resource "kubectl_manifest" "iscsi" {
  #for_each  = data.kubectl_file_documents.iscsi_doc.manifests
  #yaml_body = each.value
  yaml_body = file("${path.module}/eck-yamls/longhorn-iscsi-installation.yaml")
}
