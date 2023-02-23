resource "kubernetes_manifest" "service_eck_external_es_http" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "annotations" = {
        "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
      }
      "labels" = {
        "common.k8s.elastic.co/type" = "elasticsearch"
        "elasticsearch.k8s.elastic.co/cluster-name" = "eck"
      }
      "name" = "eck-external-es-http"
      "namespace" = var.eck_namespace
    }
    "spec" = {
      "externalTrafficPolicy" = "Local"
      "ports" = [
        {
          "name" = "https"
          "port" = 9200
          "protocol" = "TCP"
          "targetPort" = 9200
        },
      ]
      "selector" = {
        "common.k8s.elastic.co/type" = "elasticsearch"
        "elasticsearch.k8s.elastic.co/cluster-name" = "eck"
        "elasticsearch.k8s.elastic.co/node-master" = "false"
      }
      "sessionAffinity" = "None"
      "type" = "LoadBalancer"
    }
  }
depends_on = [kubernetes_manifest.kibana_eck]
}
