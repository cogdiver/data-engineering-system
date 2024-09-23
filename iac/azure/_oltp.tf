# Create a PostgreSQL server in Azure
resource "azurerm_postgresql_flexible_server" "server" {
  name                = "${var.project_name_base}-server"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  administrator_login    = var.db_username
  administrator_password = var.db_password

  sku_name   = "GP_Standard_D4s_v3"
  storage_mb = 32768
  version    = "16"
  zone = "1"

  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  auto_grow_enabled                = true
  public_network_access_enabled    = true # false to production
}

# Create a database in the PostgreSQL server
resource "azurerm_postgresql_flexible_server_database" "db" {
  name                = "${var.project_name_base}-database"
  server_id           = azurerm_postgresql_flexible_server.server.id
  charset             = "UTF8"
}
