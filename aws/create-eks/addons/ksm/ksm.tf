resource "helm_release" "ksm" {
  name           = "ksm"
  namespace      = "kube-system"
  repository     = "https://prometheus-community.github.io/helm-charts"
  chart          = "kube-state-metrics"
  create_namespace = true
}
