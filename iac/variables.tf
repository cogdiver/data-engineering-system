########################## AWS Variables

########################## Azure Variables

########################## GCP Variables
# GCP Provider Variables
variable "gcp_project" {
  description = "The GCP project ID"
  type = string
}

variable "gcp_region" {
  description = "The GCP region to deploy resources in"
  type = string
}

variable "gcp_project_name_base" {
  description = "The name of the GCS bucket to create"
  type        = string
}

# Cloud SQL
variable "gcp_db_username" {
  description = "The master username for the database"
  type        = string
}

variable "gcp_db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}
