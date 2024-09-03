# GCP Provider Variables
variable "project" {
  description = "The GCP project ID"
  type = string
}

variable "region" {
  description = "The GCP region to deploy resources in"
  type = string
  default = "us-central1"
}

variable "project_name_base" {
  description = "The name of the GCS bucket to create"
  type        = string
}

# Cloud SQL
variable "db_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}
