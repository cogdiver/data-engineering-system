# Create a service account
resource "google_service_account" "service_accounts" {
  for_each     = local.sa_components
  account_id   = "sa-${var.project_name_base}-${each.key}"
  display_name = "SA to ${each.key} Component"
}

# Define a custom role
resource "google_project_iam_custom_role" "custom_roles" {
  for_each    = local.sa_components
  role_id     = "role_${var.project_name_base}_${each.key}"
  title       = "Role to ${each.key} Component"
  # description = "A custom role with specific permissions"
  permissions = each.value
}

# Assign the custom role to the service account
resource "google_project_iam_member" "sa_role_bindings" {
  for_each = local.sa_components
  project = var.project
  role    = google_project_iam_custom_role.custom_roles[each.key].name
  member  = "serviceAccount:${google_service_account.service_accounts[each.key].email}"
}
