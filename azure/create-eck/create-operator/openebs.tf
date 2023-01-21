resource "helm_release" "openebs" {
  name           = "openebs"
  namespace      = "openebs"
  repository     = "https://openebs.github.io/charts"
  chart          = "openebs"
  create_namespace = true
  set {
    name  = "ocalprovisioner.basePath"
    value = "/srv/local"
  }
}

