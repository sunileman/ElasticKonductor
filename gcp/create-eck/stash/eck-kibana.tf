resource "kubernetes_manifest" "kibana_eck" {
  manifest = {
    "apiVersion" = "kibana.k8s.elastic.co/v1"
    "kind" = "Kibana"
    "metadata" = {
      "name" = "eck"
      "namespace" = var.eck_namespace
    }
    "spec" = {
      "count" = 1
      "elasticsearchRef" = {
        "name" = "eck"
      }
      "http" = {
        "service" = {
          "metadata" = {
            "annotations" = {
              "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
            }
          }
          "spec" = {
            "type" = "LoadBalancer"
          }
        }
        "tls" = {
          "selfSignedCertificate" = {
            "subjectAltNames" = [
              {
                "dns" = "*.us-east-1.elb.amazonaws.com"
              },
            ]
          }
        }
      }
      "podTemplate" = {
        "spec" = {
          "containers" = [
            {
              "name" = "kibana"
              "resources" = {
                "requests" = {
                  "cpu" = var.kibana_pod_cpu
                  "memory" = var.kibana_pod_memory
                }
              }
            },
          ]
          "nodeSelector" = {
            "nodetype" = "kibana"
          }
        }
      }
      "version" = var.es_version
    }
  }
depends_on = [kubernetes_manifest.elasticsearch_eck]
}
