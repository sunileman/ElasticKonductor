resource "null_resource" "fetch_eck_yaml" {
  provisioner "local-exec" {
    command = "python fetch-operator-yaml.py ${data.terraform_remote_state.k8s.outputs.eck_version}"
  }
}

resource "null_resource" "modify_operator_yaml" {
  provisioner "local-exec" {
    command = "python modify-operator-yaml.py"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [kubectl_manifest.elastic_crds, null_resource.fetch_eck_yaml ]
}

