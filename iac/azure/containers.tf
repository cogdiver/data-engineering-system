# Create the ACR repositories
resource "azurerm_container_registry" "repo" {
  name                = "${var.project_name_base}repo"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "Basic"
  admin_enabled       = true
}
