# AWS module
module "aws" {
  count           = var.deploy_aws ? 1 : 0
  source          = "./aws"
  # region          = var.aws_region
  # bucket_name     = var.s3_bucket_name
  # local_directory = trimsuffix(trimspace(var.local_directory), "/")
  # rds_sg_name     = var.aws_rds_sg_name
  # vpc_id          = var.aws_vpc_id
  # subnet_name     = var.aws_subnet_name
  # db_name         = var.aws_db_name
  # db_identifier   = var.aws_db_identifier
  # db_username     = var.aws_db_username
  # db_password     = var.aws_db_password
  # ami_id          = var.aws_ami_id
}

# Azure module
module "azure" {
  count               = var.deploy_az ? 1 : 0
  source              = "./azure"
  # resource_group_name = var.az_resource_group_name
  # region              = var.az_region
  # bucket_account_name = var.az_bucket_account_name
  # bucket_name         = var.blob_bucket_name
  # local_directory     = trimsuffix(trimspace(var.local_directory), "/")
  # db_name             = var.az_db_name
  # db_username         = var.az_db_username
  # db_password         = var.az_db_password
}

# GCP module
module "gcp" {
  count             = var.deploy_gcp ? 1 : 0
  source            = "./gcp"
  project           = var.gcp_project
  region            = var.gcp_region
  project_name_base = var.gcp_project_name_base
  db_username       = var.gcp_db_username
  db_password       = var.gcp_db_password
}
