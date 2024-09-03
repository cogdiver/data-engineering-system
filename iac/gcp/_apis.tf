# Resource to enable multiple GCP APIs
resource "google_project_service" "enable_apis" {
  for_each = toset(local.apis_to_enable)
  project  = var.project
  service  = each.value

  # Disable dependent services when this API is disabled
  disable_dependent_services = true

  # Disable the service on destroy
  disable_on_destroy = true
}
