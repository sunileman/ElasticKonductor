resource "random_string" "kibanaLbName" {
  length  = 16
  special = false
  upper   = false
  numeric = false
}

resource "helm_release" "kibana" {
  name       = "kibana"
  chart      = "eck-kibana"
  version    = var.kibana_chart_version
  repository = "https://helm.elastic.co"
  namespace  = var.eck_namespace

  set {
    name  = "fullnameOverride"
    value = "eck-kibana"
  }

  set {
    name  = "version"
    value = var.es_version
  }

  set {
    name  = "spec.count"
    value = var.kibana_pod_count
  }

  set {
    name  = "spec.elasticsearchRef.name"
    value = "eck-elasticsearch"
  }

  set {
    name  = "spec.enterpriseSearchRef.name"
    value = var.entsearch_pod_count > 0 || var.entsearch_instance_count > 1 ? "enterprise-search" : ""
  }



  set {
    name  = "spec.podTemplate.spec.nodeSelector.nodetype"
    value = "kibana"
  }

  set {
    name  = "spec.podTemplate.spec.containers[0].name"
    value = "kibana"
  }

  set {
    name  = "spec.podTemplate.spec.containers[0].resources.requests.memory"
    value = var.kibana_pod_memory
  }

  set {
    name  = "spec.podTemplate.spec.containers[0].resources.requests.cpu"
    value = var.kibana_pod_cpu
  }


  set {
    name  = "spec.http.services.metadata.annpodTemplate.spec.containers[0].resources.requests.cpu"
    value = var.kibana_pod_cpu
  }

  set {
    name  = "spec.http.service.metadata.annotations.service\\.beta\\.kubernetes\\.io/azure-dns-label-name"
    value = random_string.kibanaLbName.result
  }

  set {
    name  = "spec.http.service.spec.type"
    value = "LoadBalancer"
  }

  set {
    name  = "spec.http.tls.selfSignedCertificate.subjectAltNames[0].dns"
    value = "*.cloudapp.azure.com"
  }

  values = [
    "${file("${path.module}/values.yaml")}"
  ]

}
