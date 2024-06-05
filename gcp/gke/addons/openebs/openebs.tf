resource "helm_release" "openebs" {
  name           = "openebs"
  namespace      = "openebs"
  repository     = "https://openebs.github.io/charts"
  chart          = "openebs"
  version        = var.openebs_helm_chart_version
  create_namespace = true
  set {
    name  = "localprovisioner.deviceClass.name"
    value = "local-storage-device"
  }
  set {
    name  = "localprovisioner.hostpathClass.name"
    value = "local-storage"
  }
  set {
    name  = "localprovisioner.hostpathClass.enabled"
    value = "true"
  }
  set {
    name  = "localprovisioner.basePath"
    value = "/mnt/stateful_partition/kube-ephemeral-ssd"
  }
}