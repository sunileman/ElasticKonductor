resource "kubernetes_secret" "es-credentials" {
  metadata {
    name = "es-credentials"
  }

  data = {
    "enterprise-search.yml" = <<EOF
elasticsearch.username: elastic
elasticsearch.password: ${data.external.k8s_secret.result["secret"]}
EOF
  }

  type = "Opaque"
}