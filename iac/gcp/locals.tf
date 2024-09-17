locals {
  # List of GCP APIs to enable
  apis_to_enable = [
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
    "artifactregistry.googleapis.com",
    "dataflow.googleapis.com",
    "dataplex.googleapis.com",
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
    "bigquery.googleapis.com",
    "cloudbuild.googleapis.com",
  ]

  # components that will use service account
  iam_components = {
    "ui" = [
      "storage.objects.get"
    ],
    "backend" = [
      "storage.objects.create"
    ],
    "trigger" = [
      "storage.objects.delete"
    ],
  }
}
