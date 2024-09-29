# Create an Azure Storage Account
resource "azurerm_storage_account" "bucket_account" {
  name                     = "project${var.project_name_base}storageaccount"
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create an Azure Storage Container (equivalent to a bucket)
resource "azurerm_storage_container" "bucket" {
  name                  = "${var.project_name_base}-container"
  storage_account_name  = azurerm_storage_account.bucket_account.name
}
