# Specify the required version of Terraform
terraform {
  required_version = ">= 1.0.0"

  # Specify the required providers and their versions
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
