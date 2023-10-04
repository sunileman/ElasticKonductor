# Read the content of the local file
data "local_file" "iscsi" {
  filename = "${path.module}/yamls/longhorn-iscsi-installation.yaml"
}

# Use the content of the local file in kubectl_file_documents
data "kubectl_file_documents" "iscsi_doc" {
  content = data.local_file.iscsi.content
}