# Specify the required version of Terraform
terraform {
  # Specify the required providers and their versions
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}
