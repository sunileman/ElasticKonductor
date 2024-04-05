resource "helm_release" "eck-fleet-server" {
  count      = var.fleet_instance_count > 0 || var.fleet_pod_count > 0 ? 1 : 0
  name       = "elastic-fleet"
  chart      = "eck-fleet-server"
  version    = var.fleet_server_chart_version
  repository = "https://helm.elastic.co"
  namespace  =  var.eck_namespace


  set {
    name  = "version"
    value = var.es_version
  }

  set {
    name  = "fullnameOverride"
    value = "fleet-server"
  }


  set {
    name  = "spec.elasticsearchRef.name"
    value = "eck-elasticsearch"
  }


  set {
    name  = "spec.kibanaRef.name"
    value = "eck-kibana"
  }


  values = [
    templatefile(
      "${path.module}/values.tpl", 
      { 
        fleet_pod_memory = var.fleet_pod_memory,
        fleet_pod_cpu = var.fleet_pod_cpu,
        fleet_pod_count = var.fleet_pod_count
      }
      )]

}




