# Create a Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                        = "${var.project_name_base}-project-key-vault"
  location                    = azurerm_resource_group.default.location
  resource_group_name         = azurerm_resource_group.default.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7

  # Access permissions for the Key Vault
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Get", "List", "Set"]
    key_permissions = ["Get", "List"]
    storage_permissions = ["Get", "List"]
  }
}

# Add a secret to Key Vault
resource "azurerm_key_vault_secret" "secret" {
  name         = "${var.project_name_base}-secret"
  value        = "${var.project_name_base}-secret-value"
  key_vault_id = azurerm_key_vault.key_vault.id
}
