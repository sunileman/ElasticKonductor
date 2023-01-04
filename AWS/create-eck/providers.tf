terraform {
  required_version = ">= 1.2.0"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}



provider "kubernetes" {
  config_path = "~/.kube/config"
}
