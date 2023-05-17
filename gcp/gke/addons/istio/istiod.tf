resource "helm_release" "istiod" {
  name           = "istiod"
  namespace      = "istio-system"
  force_update   = true
  repository     = "https://istio-release.storage.googleapis.com/charts"
  chart          = "istiod"
  version        = var.istiod_helm_chart_version
  #helm search repo istio/istiod --versions
  create_namespace = true
  
  set {
    name  = "pilot.nodeSelector.nodetype"
    value = "util"
  }
  
  depends_on = [helm_release.istio-base]

}