######################################
### Flags Variables
######################################
variable "deploy_aws" {
  description = "Flag to deploy AWS services"
  type        = bool
  default     = false
}

variable "deploy_az" {
  description = "Flag to deploy AZURE services"
  type        = bool
  default     = false
}

variable "deploy_gcp" {
  description = "Flag to deploy GCP services"
  type        = bool
  default     = false
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
  description = "Base name of the AWS resources to create"
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
# Azure Provider Variables
variable "az_resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "az_region" {
  description = "The Azure region to deploy resources in"
  type = string
}

variable "az_project_name_base" {
  description = "Base name of the AZURE resources to create"
  type        = string
}

# SQL databases Variables
variable "az_db_username" {
  description = "The master username for the database"
  type        = string
}

variable "az_db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

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
  description = "Base name of the GCP resources to create"
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
