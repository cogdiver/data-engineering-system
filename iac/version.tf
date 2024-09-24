# Specify the required version of Terraform
terraform {
  required_version = ">= 1.0.0" # 1.8.5

  # Specify the required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # 5.68.0
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # 4.3.0
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0" # 6.4.0
    }
  }
}
