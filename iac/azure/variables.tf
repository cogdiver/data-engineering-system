# Azure Provider Variables
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "region" {
  description = "The Azure region to deploy resources in"
  type = string
}

variable "project_name_base" {
  description = "Base name of the AZURE resources to create"
  type        = string
}

# SQL databases Variables
variable "db_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}
