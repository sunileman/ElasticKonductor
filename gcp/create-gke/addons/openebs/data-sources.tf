data "curl" "iscsi" {
  http_method = "GET"
  uri = "https://raw.githubusercontent.com/longhorn/longhorn/v1.4.0/deploy/prerequisite/longhorn-iscsi-installation.yaml"
}

data "kubectl_file_documents" "iscsi_doc" {
  content = data.curl.iscsi.response
}
