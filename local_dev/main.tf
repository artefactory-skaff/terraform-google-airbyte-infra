module "airbyte" {
  source  = "../"

  project_id = var.project_id
  region     = var.region # List available regions with `gcloud compute regions list`
  zone       = var.zone   # List available zones with `gcloud compute zones list`
}