resource "kubernetes_secret" "elastic_apm_secret" {
  metadata {
    name = "elastic-apm-secret"
  }

  data = {
    elastic_apm_endpoint = var.es_apm_url
    elastic_apm_secret_token = var.es_apm_token
  }
}