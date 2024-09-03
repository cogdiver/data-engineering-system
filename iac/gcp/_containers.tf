resource "google_artifact_registry_repository" "repo" {
  location     = var.region # Ajusta la región según tus necesidades
  repository_id = "${var.project_name_base}-repository"
  format       = "DOCKER"
  # description = "My artifacts repository"
}
