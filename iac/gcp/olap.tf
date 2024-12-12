resource "google_bigquery_dataset" "my_dataset" {
  depends_on = [ google_project_service.enable_apis ]
  dataset_id    = "${var.project_name_base}_dataset"
  location      = var.region
  # description   = "BigQuery Dataset"
  friendly_name = "${var.project_name_base} Dataset"
}
