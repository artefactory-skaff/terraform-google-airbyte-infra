variable "project_id" {
    description = "The GCP project ID"
    type        = string
}

variable "region" {
    description = "The GCP region, e.g. europe-west1. List available regions with `gcloud compute regions list`"
    type        = string
}

variable "zone" {
    description = "The GCP zone, e.g. europe-west1-c. List available zones with `gcloud compute zones list`."
    type        = string
}
