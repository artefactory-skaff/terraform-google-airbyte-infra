resource "google_compute_network" "airbyte_vpc" {
  project                         = var.project_id
  name                            = var.config.vpc_name
  description                     = "VPC network for Airbyte"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "airbyte_subnet" {
  project                  = var.project_id
  region                   = var.region
  name                     = var.config.subnet_name
  description              = "Subnet ${var.region}"
  ip_cidr_range            = var.config.ip_cidr_range
  network                  = google_compute_network.airbyte_vpc.id
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  project = var.project_id
  region  = var.region
  name    = var.config.router_name
  network = google_compute_network.airbyte_vpc.id
}

resource "google_compute_address" "airbyte_external_ip" {
  project = var.project_id
  region  = var.region
  name    = var.config.external_ip_name
}

resource "google_compute_router_nat" "airbyte_nat" {
  project                = var.project_id
  region                 = var.region
  name                   = var.config.nat_name
  router                 = google_compute_router.router.name
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.airbyte_external_ip.id]
  min_ports_per_vm       = 64

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  lifecycle {
    replace_triggered_by = [google_compute_address.airbyte_external_ip]
  }
}

resource "google_compute_route" "internet_route" {
  project          = var.project_id
  name             = var.config.internet_route_name
  description      = "Route to internet gateway from the Airbyte VM"
  network          = google_compute_network.airbyte_vpc.id
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

resource "google_compute_firewall" "allow_ssh_from_iap" {
  project     = var.project_id
  name        = var.config.ssh_from_iap_firewall_name
  description = "Allow SSH from IAP"
  direction   = "INGRESS"
  network     = google_compute_network.airbyte_vpc.id

  source_ranges = ["35.235.240.0/20"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_internal_traffic" {
  project     = var.project_id
  name        = var.config.internal_traffic_firewall_name
  description = "Allow internal traffic within VPC"
  direction   = "INGRESS"
  network     = google_compute_network.airbyte_vpc.id

  source_ranges = ["10.0.1.0/24"]

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
}
