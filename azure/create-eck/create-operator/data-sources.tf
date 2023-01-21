data "curl" "elastic_crds" {
  http_method = "GET"
  uri = "https://download.elastic.co/downloads/eck/${var.eck_version}/crds.yaml"
}

data "kubectl_file_documents" "elastic_crds_doc" {
  content = data.curl.elastic_crds.response
}

data "curl" "iscsi" {
  http_method = "GET"
  uri = "https://raw.githubusercontent.com/longhorn/longhorn/v1.4.0/deploy/prerequisite/longhorn-iscsi-installation.yaml"
}

data "kubectl_file_documents" "iscsi_doc" {
  content = data.curl.iscsi.response
}

