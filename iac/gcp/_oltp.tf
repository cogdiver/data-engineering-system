# Create a Cloud SQL instance for PostgreSQL
resource "google_sql_database_instance" "instance" {
  depends_on       = [ google_project_service.enable_apis ]
  name             = "${var.project_name_base}-db-instance"
  database_version = "POSTGRES_16"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    # Configure backup settings
    backup_configuration {
      enabled    = true
      start_time = "02:00"
    }

    # Configure IP configuration
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "allow-all"
        value = "0.0.0.0/0"
      }
    }
  }

  deletion_protection = false
}

# Create a PostgreSQL database
resource "google_sql_database" "postgres_db" {
  name     = "${var.project_name_base}-db"
  instance = google_sql_database_instance.instance.name
}

# Create a user for the database
resource "google_sql_user" "postgres_user" {
  name     = var.db_username
  instance = google_sql_database_instance.instance.name
  password = var.db_password
}
