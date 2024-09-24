# Create a storage account needed for Azure Synapse Analytics
resource "azurerm_storage_account" "storage" {
  name                     = "${var.project_name_base}synapsestorage"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create Data Lake Storage
resource "azurerm_storage_data_lake_gen2_filesystem" "datalake" {
  name               = "${var.project_name_base}datalake"
  storage_account_id = azurerm_storage_account.storage.id
}

# Create an Azure Synapse workspace
resource "azurerm_synapse_workspace" "workspace" {
  name                = "${var.project_name_base}synapseworkspace"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.datalake.id

  sql_administrator_login          = var.db_username
  sql_administrator_login_password = var.db_password

  identity {
    type = "SystemAssigned"
  }
}

# Create a Synapse SQL Pool
resource "azurerm_synapse_sql_pool" "pool" {
  name                 = "${var.project_name_base}pool"
  synapse_workspace_id = azurerm_synapse_workspace.workspace.id
  sku_name             = "DW100c"
  storage_account_type = "GRS"
}
