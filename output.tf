output "airbyte_vm_name" {
  value = google_compute_instance.airbyte_vm.name
}

output "airbyte_service_account" {
  value = google_service_account.airbyte.email
}

output "airbyte_vpc" {
  value = google_compute_network.airbyte_vpc.name
}

output "airbyte_subnet" {
  value = google_compute_subnetwork.airbyte_subnet.name
}

output "airbyte_router" {
  value = google_compute_router.router.name
}

output "airbute_nat" {
  value = google_compute_router_nat.airbyte_nat.name
}

output "airbyte_address" {
  value = google_compute_address.airbyte_external_ip.name
}

