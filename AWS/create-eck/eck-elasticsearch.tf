resource "kubernetes_manifest" "elasticsearch_eck" {
  manifest = {
    "apiVersion" = "elasticsearch.k8s.elastic.co/v1"
    "kind" = "Elasticsearch"
    "metadata" = {
      "name" = "eck",
      "namespace" = var.eck_namespace
    }
    "spec" = {
      "http" = {
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
      "nodeSets" = [
        {
          "config" = {
            "node.roles" = local.master_pod_roles
            "transport.compress" = true
          }
          "count" = var.master_pod_count
          "name" = "master"
          "podTemplate" = {
            "metadata" = {
              "annotations" = {
                "co.elastic.metrics/raw" = "[{\"enabled\":true,\"module\":\"elasticsearch\",\"period\":\"10s\",\"hosts\":\"https://$${data.host}:9200\",\"username\":\"beat\",\"password\":\"beatbeatbeat\",\"ssl.verification_mode\":\"none\",\"xpack.enabled\": true}]"
              }
              "labels" = {
                "foo" = "compress"
              }
            }
            "spec" = {
              "containers" = [
                {
                  "env" = [
                    {
                      "name" = "ES_JAVA_OPTS"
                      "value" = var.master_pod_ES_JAVA_OPTS
                    },
                  ]
                  "name" = "elasticsearch"
                  "resources" = {
                    "limits" = {
                      "cpu" = var.master_pod_cpu
                      "memory" = var.master_pod_memory
                    }
                  }
                },
              ]
              "initContainers" = [
                {
                  "command" = [
                    "sh",
                    "-c",
                    <<-EOT
                    bin/elasticsearch-plugin install --batch repository-s3
                    
                    EOT
                    ,
                  ]
                  "name" = "install-plugins"
                },
              ]
              "nodeSelector" = {
                "nodetype" = "master"
              }
            }
          }
          "volumeClaimTemplates" = [
            {
              "metadata" = {
                "name" = "elasticsearch-data"
              }
              "spec" = {
                "accessModes" = [
                  "ReadWriteOnce",
                ]
                "resources" = {
                  "requests" = {
                    "storage" = var.master_pod_storage
                  }
                }
                "storageClassName" = "openebs-hostpath"
              }
            },
          ]
        },
        {
          "config" = {
            "node.attr.data" = "hot"
            "node.roles" =  local.hot_pod_roles
            "transport.compress" = true
          }
          "count" = var.hot_pod_count
          "name" = "hot"
          "podTemplate" = {
            "metadata" = {
              "annotations" = {
                "co.elastic.metrics/raw" = "[{\"enabled\":true,\"module\":\"elasticsearch\",\"period\":\"10s\",\"hosts\":\"https://$${data.host}:9200\",\"username\":\"beat\",\"password\":\"beatbeatbeat\",\"ssl.verification_mode\":\"none\",\"xpack.enabled\": true}]"
              }
              "labels" = {
                "foo" = "compress"
              }
            }
            "spec" = {
              "containers" = [
                {
                  "env" = [
                    {
                      "name" = "ES_JAVA_OPTS"
                      "value" = var.hot_pod_ES_JAVA_OPTS
                    },
                  ]
                  "name" = "elasticsearch"
                  "resources" = {
                    "limits" = {
                      "cpu" = var.hot_pod_cpu
                      "memory" = var.hot_pod_memory
                    }
                  }
                },
              ]
              "initContainers" = [
                {
                  "command" = [
                    "sh",
                    "-c",
                    <<-EOT
                    bin/elasticsearch-plugin install --batch repository-s3
                    
                    EOT
                    ,
                  ]
                  "name" = "install-plugins"
                },
              ]
              "nodeSelector" = {
                "nodetype" = "hot"
              }
            }
          }
          "volumeClaimTemplates" = [
            {
              "metadata" = {
                "name" = "elasticsearch-data"
              }
              "spec" = {
                "accessModes" = [
                  "ReadWriteOnce",
                ]
                "resources" = {
                  "requests" = {
                    "storage" = var.hot_pod_storage
                  }
                }
                "storageClassName" = "openebs-hostpath"
              }
            },
          ]
        },
        {
          "config" = {
            "node.attr.data" = "warm"
            "node.roles" = local.warm_pod_roles
            "transport.compress" = true
          }
          "count" = var.warm_pod_count
          "name" = "warm"
          "podTemplate" = {
            "metadata" = {
              "annotations" = {
                "co.elastic.metrics/raw" = "[{\"enabled\":true,\"module\":\"elasticsearch\",\"period\":\"10s\",\"hosts\":\"https://$${data.host}:9200\",\"username\":\"beat\",\"password\":\"beatbeatbeat\",\"ssl.verification_mode\":\"none\",\"xpack.enabled\": true}]"
              }
              "labels" = {
                "foo" = "compress"
              }
            }
            "spec" = {
              "containers" = [
                {
                  "env" = [
                    {
                      "name" = "ES_JAVA_OPTS"
                      "value" = var.warm_pod_ES_JAVA_OPTS
                    },
                  ]
                  "name" = "elasticsearch"
                  "resources" = {
                    "limits" = {
                      "cpu" = var.warm_pod_cpu
                      "memory" = var.warm_pod_memory
                    }
                  }
                },
              ]
              "initContainers" = [
                {
                  "command" = [
                    "sh",
                    "-c",
                    <<-EOT
                    bin/elasticsearch-plugin install --batch repository-s3
                    
                    EOT
                    ,
                  ]
                  "name" = "install-plugins"
                },
              ]
              "nodeSelector" = {
                "nodetype" = "warm"
              }
            }
          }
          "volumeClaimTemplates" = [
            {
              "metadata" = {
                "name" = "elasticsearch-data"
              }
              "spec" = {
                "accessModes" = [
                  "ReadWriteOnce",
                ]
                "resources" = {
                  "requests" = {
                    "storage" = var.warm_pod_storage
                  }
                }
                "storageClassName" = "openebs-hostpath"
              }
            },
          ]
        },
        {
          "config" = {
            "node.attr.data" = "cold"
            "node.roles" = local.cold_pod_roles
            "transport.compress" = true
          }
          "count" = var.cold_pod_count
          "name" = "cold"
          "podTemplate" = {
            "metadata" = {
              "annotations" = {
                "co.elastic.metrics/raw" = "[{\"enabled\":true,\"module\":\"elasticsearch\",\"period\":\"10s\",\"hosts\":\"https://$${data.host}:9200\",\"username\":\"beat\",\"password\":\"beatbeatbeat\",\"ssl.verification_mode\":\"none\",\"xpack.enabled\": true}]"
              }
              "labels" = {
                "foo" = "compress"
              }
            }
            "spec" = {
              "containers" = [
                {
                  "env" = [
                    {
                      "name" = "ES_JAVA_OPTS"
                      "value" = var.cold_pod_ES_JAVA_OPTS
                    },
                  ]
                  "name" = "elasticsearch"
                  "resources" = {
                    "limits" = {
                      "cpu" = var.cold_pod_cpu
                      "memory" = var.cold_pod_memory
                    }
                  }
                },
              ]
              "initContainers" = [
                {
                  "command" = [
                    "sh",
                    "-c",
                    <<-EOT
                    bin/elasticsearch-plugin install --batch repository-s3
                    
                    EOT
                    ,
                  ]
                  "name" = "install-plugins"
                },
              ]
              "nodeSelector" = {
                "nodetype" = "cold"
              }
            }
          }
          "volumeClaimTemplates" = [
            {
              "metadata" = {
                "name" = "elasticsearch-data"
              }
              "spec" = {
                "accessModes" = [
                  "ReadWriteOnce",
                ]
                "resources" = {
                  "requests" = {
                    "storage" = var.cold_pod_storage
                  }
                }
                "storageClassName" = "openebs-hostpath"
              }
            },
          ]
        },
        {
          "config" = {
            "node.attr.data" = "frozen"
            "node.roles" = local.frozen_pod_roles
            "transport.compress" = true
          }
          "count" = var.frozen_pod_count
          "name" = "frozen"
          "podTemplate" = {
            "metadata" = {
              "annotations" = {
                "co.elastic.metrics/raw" = "[{\"enabled\":true,\"module\":\"elasticsearch\",\"period\":\"10s\",\"hosts\":\"https://$${data.host}:9200\",\"username\":\"beat\",\"password\":\"beatbeatbeat\",\"ssl.verification_mode\":\"none\",\"xpack.enabled\": true}]"
              }
              "labels" = {
                "foo" = "compress"
              }
            }
            "spec" = {
              "containers" = [
                {
                  "env" = [
                    {
                      "name" = "ES_JAVA_OPTS"
                      "value" = var.frozen_pod_ES_JAVA_OPTS
                    },
                  ]
                  "name" = "elasticsearch"
                  "resources" = {
                    "limits" = {
                      "cpu" = var.frozen_pod_cpu
                      "memory" = var.frozen_pod_memory
                    }
                  }
                },
              ]
              "initContainers" = [
                {
                  "command" = [
                    "sh",
                    "-c",
                    <<-EOT
                    bin/elasticsearch-plugin install --batch repository-s3
                    
                    EOT
                    ,
                  ]
                  "name" = "install-plugins"
                },
              ]
              "nodeSelector" = {
                "nodetype" = "frozen"
              }
            }
          }
          "volumeClaimTemplates" = [
            {
              "metadata" = {
                "name" = "elasticsearch-data"
              }
              "spec" = {
                "accessModes" = [
                  "ReadWriteOnce",
                ]
                "resources" = {
                  "requests" = {
                    "storage" = var.frozen_pod_storage
                  }
                }
                "storageClassName" = "openebs-hostpath"
              }
            },
          ]
        },
        {
          "config" = {
            "node.roles" = local.ml_pod_roles
            "transport.compress" = true
            "xpack.ml.enabled" = true
          }
          "count" = var.ml_pod_count
          "name" = "ml"
          "podTemplate" = {
            "metadata" = {
              "annotations" = {
                "co.elastic.metrics/raw" = "[{\"enabled\":true,\"module\":\"elasticsearch\",\"period\":\"10s\",\"hosts\":\"https://$${data.host}:9200\",\"username\":\"beat\",\"password\":\"beatbeatbeat\",\"ssl.verification_mode\":\"none\",\"xpack.enabled\": true}]"
              }
              "labels" = {
                "foo" = "compress"
              }
            }
            "spec" = {
              "containers" = [
                {
                  "env" = [
                    {
                      "name" = "ES_JAVA_OPTS"
                      "value" = var.ml_pod_ES_JAVA_OPTS
                    },
                  ]
                  "name" = "elasticsearch"
                  "resources" = {
                    "limits" = {
                      "cpu" = var.ml_pod_cpu
                      "memory" = var.ml_pod_memory
                    }
                  }
                },
              ]
              "initContainers" = [
                {
                  "command" = [
                    "sh",
                    "-c",
                    <<-EOT
                    bin/elasticsearch-plugin install --batch repository-s3
                    
                    EOT
                    ,
                  ]
                  "name" = "install-plugins"
                },
              ]
              "nodeSelector" = {
                "nodetype" = "ml"
              }
            }
          }
          "volumeClaimTemplates" = [
            {
              "metadata" = {
                "name" = "elasticsearch-data"
              }
              "spec" = {
                "accessModes" = [
                  "ReadWriteOnce",
                ]
                "resources" = {
                  "requests" = {
                    "storage" = var.ml_pod_storage
                  }
                }
                "storageClassName" = "openebs-hostpath"
              }
            },
          ]
        },
      ]
      "secureSettings" = [
        {
          "secretName" = "aws-key"
        },
        {
          "secretName" = "aws-secret"
        },
      ]
      "version" = var.es_version
    }
  }
depends_on = [kubernetes_manifest.createEckSecrets, helm_release.openebs, kubectl_manifest.iscsi]
}
