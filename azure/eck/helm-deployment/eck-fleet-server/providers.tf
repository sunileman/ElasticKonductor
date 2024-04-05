terraform {

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    curl = {
      source = "anschoewe/curl"
      version = "1.0.2"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }
  }
}



provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "kubectl" {
  config_path = "~/.kube/config"
}
