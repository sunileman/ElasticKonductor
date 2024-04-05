resource "helm_release" "eck-operator" {
  name       = "elastic-operator"
  chart      = "eck-operator"
  version    = var.es_operator_chart_version
  repository = "https://helm.elastic.co"
  namespace  = "elastic-system"

  set {
    name  = "installCRDs"
    value = "true"
  }
  set {
    name  = "resources.limits.cpu"
    value = "1"
  }

  set {
    name  = "resources.limits.memory"
    value = "1Gi"
  }

  set {
    name  = "resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "resources.requests.memory"
    value = "150Mi"
  }

  values = [templatefile("${path.module}/values.tpl", { nodetype = var.eck_operator_instance_affinity})]



}