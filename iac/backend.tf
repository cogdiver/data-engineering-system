# Configure Terraform backend to use Google Cloud Storage
terraform {
  backend "gcs" {
    bucket  = "data-engineering-system"
    prefix  = "terraform/state"
  }
}
