terraform {

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.19.0"
    }
    curl = {
      source = "anschoewe/curl"
      version = "1.0.2"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}



provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "kubectl" {
  config_path = "~/.kube/config"
}
