# Create custom role definitions for each component
resource "azurerm_role_definition" "roles" {
  for_each = local.iam_components

  name        = "custom-role-${each.key}"
  scope       = data.azurerm_subscription.primary.id
  description = "Custom role for ${each.key} component"

  permissions {
    actions     = each.value.actions
    not_actions = each.value.no_actions
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

# Create User Assigned Managed Identity for each component
resource "azurerm_user_assigned_identity" "identities" {
  for_each = local.iam_components

  name                = "custom-identity-${each.key}"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

# Assign the custom role to the Managed Identity
resource "azurerm_role_assignment" "component_assignments" {
  for_each               = local.iam_components

  scope                  = data.azurerm_subscription.primary.id
  role_definition_name   = azurerm_role_definition.component_roles[each.key].name
  principal_id           = azurerm_user_assigned_identity.component_identities[each.key].principal_id
}
