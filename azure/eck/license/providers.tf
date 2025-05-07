terraform {
  required_version = ">= 1.8.5"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.19.0" }
  }
}


provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "kubectl" {
  config_path = "~/.kube/config"
}
