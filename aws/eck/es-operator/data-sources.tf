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

data "external" "modify_yaml" {
  program = ["python3", "${path.module}/modify-operator-yaml.py"]

  query = {
    yaml_content = data.curl.elastic_operator.response
  }
}


resource "local_file" "modified_operator_yaml" {
  content  = data.external.modify_yaml.result.modified_yaml
  filename = "${path.module}/eck-yamls/modified_operator.yaml"
}

data "kubectl_file_documents" "elastic_operator_doc" {
  content = local_file.modified_operator_yaml.content
}