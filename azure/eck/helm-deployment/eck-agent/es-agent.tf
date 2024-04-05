resource "helm_release" "eck-agent" {
  count      = var.deploy_elastic_agent == "true" ? 1 : 0
  name       = "elastic-agent"
  chart      = "eck-agent"
  version    = var.es_agent_chart_version
  repository = "https://helm.elastic.co"
  namespace  =  var.eck_namespace


  set {
    name  = "version"
    value = var.es_version
  }

  set {
    name  = "spec.policyID"
    value = "eck-agent"
  }


  set {
    name  = "spec.kibanaRef.name"
    value = "eck-kibana"
  }

  set {
    name  = "spec.fleetServerRef.name"
    value = "fleet-server"
  }

  set {
    name  = "spec.mode"
    value = "fleet"
  }

  # values = [
  #   "${file("${path.module}/values.yaml")}"
  # ]

  values = [templatefile("${path.module}/values.yaml", {
        deployment_type = var.elastic_agent_deployment_type
        elastic_agent_pod_memory = var.elastic_agent_pod_memory
        elastic_agent_pod_cpu = var.elastic_agent_pod_cpu
  })]

}