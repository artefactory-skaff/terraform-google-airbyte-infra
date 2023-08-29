resource "google_compute_instance" "airbyte_vm" {
  project     = var.project_id
  zone        = var.zone
  name        = var.config.airbyte_vm_name
  description = "Compute engine running Airbyte"

  machine_type = var.config.vm_machine_type
  tags         = var.config.network_tags
  labels       = var.config.labels

  allow_stopping_for_update = true
  desired_status            = "RUNNING"
  can_ip_forward            = false
  deletion_protection       = false

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = var.config.vm_disk_size
    }
    mode = "READ_WRITE"
  }

  network_interface {
    network    = google_compute_network.airbyte_vpc.id
    subnetwork = google_compute_subnetwork.airbyte_subnet.id
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  scheduling {
    automatic_restart = true
  }

  metadata_startup_script = templatefile(
    "${path.module}/vm_startup_script.sh",
    {
      "env" : file("${path.module}/airbyte_install/.env"),
      "flags" : file("${path.module}/airbyte_install/flags.yml"),
      "docker_compose" : file("${path.module}/airbyte_install/docker-compose.yaml"),
    }
  )
  metadata = {
    block-project-ssh-keys = true
  }

  service_account {
    email  = google_service_account.airbyte.email
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [metadata["ssh-keys"]]
  }

  depends_on = [google_compute_route.internet_route] # Startup script fails without internet access
}
