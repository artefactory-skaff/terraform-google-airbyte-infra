resource "google_service_account" "airbyte" {
  project      = var.project_id
  account_id   = var.config.airbyte_sa_name
  display_name = "Airbyte service account"
  description  = "Used by the Airbyte VM to perform ELT operations"
}

resource "google_project_iam_member" "airbyte_iam" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/bigquery.jobUser",
    "roles/bigquery.dataEditor",
    "roles/storage.objectAdmin"
  ])
  project = var.project_id
  role    = each.key
  member  = google_service_account.airbyte.member
}