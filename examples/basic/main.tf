/*
* This will deploy a VM with an Airbyte instance installed.
* The instance will need a few minutes to be up and running after the apply succeeds
*
* You can access the Airbyte UI through your browser at `localhost:8000` after SSH tunneling to the instance with the following command:
*
* ```shell
* gcloud --project=<PROJECT_ID> compute ssh airbyte -- -L 8000:localhost:8000 -N -f
* ```
*
* ```hcl
* module "airbyte" {
*   source  = "artefactory/airbyte-infra/google"
*   version = "~> 0"
*
*   project_id = "<PROJECT_ID>"
*   region     = "<REGION>" # List available regions with `gcloud compute regions list`
*   zone       = "<ZONE>"   # List available zones with `gcloud compute zones list`
* }
* ```
*/

module "airbyte" {
  source  = "artefactory/airbyte-infra/google"
  version = "~> 0"

  project_id = "<PROJECT_ID>"
  region     = "<REGION>" # List available regions with `gcloud compute regions list`
  zone       = "<ZONE>"   # List available zones with `gcloud compute zones list`
}