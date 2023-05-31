resource "helm_release" "otel" {
  name           = "open-telemetry"
  namespace      = "default"
  repository     = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart          = "opentelemetry-demo"
  #version        = var.otel_chart_version


  values = [
    "${file("${path.module}/values.yaml")}"
  ]

  /*Example of supplying values to values.yaml
  values = [templatefile("${path.module}/opentelemetry-demo/kubernetes/elastic-helm/values.yaml", {
    es_apm_token = var.es_apm_token,
    es_apm_url = var.es_apm_url
  })]
  */

  depends_on = [kubernetes_secret.elastic_secret]

}

