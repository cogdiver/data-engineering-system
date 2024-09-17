######################################
### Flags Variables
######################################
variable "deploy_aws" {
  description = "Flag to deploy AWS services"
  type        = bool
  default     = true
}

variable "deploy_az" {
  description = "Flag to deploy AZURE services"
  type        = bool
  default     = true
}

variable "deploy_gcp" {
  description = "Flag to deploy GCP services"
  type        = bool
  default     = true
}


######################################
### AWS Variables
######################################
# AWS Provider Variables
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "aws_project_name_base" {
  description = "The name of the S3 bucket to create"
  type        = string
}

variable "aws_vpc_id" {
  description = "The VPC ID where the project will be deployed"
  type        = string
}

# RDS database
variable "aws_db_username" {
  description = "The master username for the database"
  type        = string
}

variable "aws_db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

######################################
### Azure Variables
######################################


######################################
### GCP Variables
######################################
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
