# GCP Provider Configuration
provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

# Azure Provider Configuration
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# AWS Provider Configuration
provider "aws" {
  region = var.aws_region
}
