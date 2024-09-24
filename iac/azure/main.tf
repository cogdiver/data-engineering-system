# Specify the required version of Terraform
terraform {
  # Specify the required providers and their versions
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Configure Resource Group
resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.region
}
