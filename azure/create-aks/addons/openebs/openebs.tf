resource "helm_release" "openebs" {
  name           = "openebs"
  namespace      = "openebs"
  repository     = "https://openebs.github.io/charts"
  chart          = "openebs"
  version        = var.openebs_helm_chart_version
  create_namespace = true
  set {
    name  = "localprovisioner.basePath"
    value = "/srv/local"
  }
  depends_on = [kubectl_manifest.iscsi]
}

