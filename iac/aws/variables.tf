# AWS Provider Variables
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "project_name_base" {
  description = "The name of the S3 bucket to create"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the project will be deployed"
  type        = string
}

# RDS database
variable "db_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}
