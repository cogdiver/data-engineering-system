# Specify the required version of Terraform
terraform {
  required_version = ">= 1.0.0"

  # Specify the required providers and their versions
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
