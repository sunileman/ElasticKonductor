terraform {
  required_version = ">= 1.2.0"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.10.1"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    curl = {
      source = "anschoewe/curl"
      version = "1.0.2"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.39.1"
    }
   random = {
      source = "hashicorp/random"
      version = "3.4.3"
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
