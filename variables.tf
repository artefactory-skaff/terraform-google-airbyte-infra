#######################
# MANDATORY VARIABLES #
#######################

variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

#######################
# OPTIONAL VARIABLES  #
#######################

variable "config" {
  description = "Configuration for the Airbyte VM"
  type = object({
    vm_machine_type = optional(string, "e2-standard-2")
    vm_disk_size    = optional(number, 30)
    airbyte_vm_name = optional(string, "airbyte")
    airbyte_sa_name = optional(string, "airbyte")
    labels          = optional(map(string), {})

    vpc_name            = optional(string, "airbyte-vpc")
    subnet_name         = optional(string, "airbyte-subnet")
    ip_cidr_range       = optional(string, "10.0.1.0/24")
    router_name         = optional(string, "airbyte-router")
    external_ip_name    = optional(string, "airbyte-ip")
    nat_name            = optional(string, "airbyte-nat")
    internet_route_name = optional(string, "airbyte-internet-route")
    network_tags        = optional(list(string), [])
  })
  default = {}
}
