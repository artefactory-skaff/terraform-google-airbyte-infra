You can change the name of the resources that will be terraformed to be compliant with your naming convention.

```hcl
module "airbyte" {
  source  = "artefactory/airbyte-infra/google"
  version = "~> 0"

  project_id = "<PROJECT_ID>"
  region     = "<REGION>" # List available regions with `gcloud compute regions list`
  zone       = "<ZONE>"   # List available zones with `gcloud compute zones list`

  # The module comes with a default config that you can override.
  # Check out the config reference for more info.
  config = {
    airbyte_vm_name     = "airbyte"
    airbyte_sa_name     = "airbyte"
    vpc_name            = "airbyte-vpc"
    subnet_name         = "airbyte-subnet"
    router_name         = "airbyte-router"
    external_ip_name    = "airbyte-ip"
    nat_name            = "airbyte-nat"
    internet_route_name = "airbyte-internet-route"
  }
}
```