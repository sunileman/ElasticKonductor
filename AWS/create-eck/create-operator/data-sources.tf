data "curl" "elastic_crds" {
  http_method = "GET"
  uri = "https://download.elastic.co/downloads/eck/${var.eck_version}/crds.yaml"
}

data "kubectl_file_documents" "elastic_crds_doc" {
  content = data.curl.elastic_crds.response
}

data "curl" "elastic_operator" {
  http_method = "GET"
  uri = "https://download.elastic.co/downloads/eck/${var.eck_version}/operator.yaml"
}

data "kubectl_file_documents" "elastic_operator_doc" {
  content = data.curl.elastic_operator.response
}


