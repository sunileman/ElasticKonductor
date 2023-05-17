resource "helm_release" "istio-base" {
  name           = "istio-base"
  namespace      = "istio-system"
  force_update   = true
  repository     = "https://istio-release.storage.googleapis.com/charts"
  chart          = "base"
  version        = var.istio_helm_base_chart_version
  #helm search repo istio/base --versions
  create_namespace = true
}