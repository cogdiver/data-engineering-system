resource "google_secret_manager_secret" "secret" {
  depends_on = [ google_project_service.enable_apis ]
  secret_id  = "${var.project_name_base}-secret"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "secret_version" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = "${var.project_name_base}-secret-value"
}
