# Create a GCS bucket
resource "google_storage_bucket" "bucket" {
  name     = "${var.project_name_base}-storage"
  location = var.region
}
