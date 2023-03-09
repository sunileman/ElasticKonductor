resource "helm_release" "otel" {
  name           = "open-telemetry"
  namespace      = "default"
  repository     = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart          = "opentelemetry-demo"
  version        = var.otel_chart_version #https://github.com/open-telemetry/opentelemetry-helm-charts/releases

  #values = [
  #  "${file("values.yaml")}"
  #]  
  values = [templatefile("${path.module}/values.yaml", {
    es_apm_token = var.es_apm_token,
    es_apm_url = var.es_apm_url
  })]

}

