resource "helm_release" "ksm" {
  name           = "ksm"
  namespace      = "kube-system"
  repository     = "https://prometheus-community.github.io/helm-charts"
  chart          = "kube-state-metrics"
  version        = var.ksm_helm_chart_version
  create_namespace = true
}
