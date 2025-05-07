terraform {
  required_version = ">= 1.8.5"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.17.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.19.0"
    }
    curl = {
      source = "anschoewe/curl"
      version = "1.0.2"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
   random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "random" {
  # Configuration options
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "kubectl" {
  config_path = "~/.kube/config"
}
