/*
* You can alter which type of VM you deploy on, as well as he network config using the `config` variable
* Check out the config reference for more info.
*
* ```hcl
* module "airbyte" {
*   source  = "artefactory/airbyte-infra/google"
*   version = "~> 0"
*
*   project_id = "<PROJECT_ID>"
*   region     = "<REGION>" # List available regions with `gcloud compute regions list`
*   zone       = "<ZONE>"   # List available zones with `gcloud compute zones list`
*
*   # The module comes with a default config that you can override.
*   # Check out the config reference for more info.
*   config = {
*     vm_machine_type = "e2-standard-8"
*     vm_disk_size    = "50"
*   }
* }
* ```
*/

module "airbyte" {
  source  = "artefactory/airbyte-infra/google"
  version = "~> 0"

  project_id = "<PROJECT_ID>"
  region     = "<REGION>" # List available regions with `gcloud compute regions list`
  zone       = "<ZONE>"   # List available zones with `gcloud compute zones list`

  # The module comes with a default config that you can override.
  # Check out the config reference for more info.
  config = {
    vm_machine_type = "e2-standard-8"
    vm_disk_size    = "50"
  }
}