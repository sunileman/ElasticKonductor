terraform {
  required_version = ">= 1.2.0"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.17.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}



provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "kubectl" {
  config_path = "~/.kube/config"
}
