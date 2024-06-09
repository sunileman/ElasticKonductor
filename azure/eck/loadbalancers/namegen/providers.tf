terraform {
  required_version = ">= 1.8.5"

  required_providers {
   random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}


provider "random" {
  # Configuration options
}

