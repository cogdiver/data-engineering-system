resource "google_artifact_registry_repository" "repo" {
  depends_on = [ google_project_service.enable_apis ]
  location     = var.region # Ajusta la región según tus necesidades
  repository_id = "${var.project_name_base}-repository"
  format       = "DOCKER"
  # description = "My artifacts repository"
}
