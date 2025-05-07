terraform {
  required_version = ">= 1.8.5"

  required_providers {
   random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}


provider "random" {
  # Configuration options
}

