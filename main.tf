/*
* # terraform-google-airbyte-infra
*
* A Terraform module to deploy an Airbyte server on a GCP compute engine instance.
*
* - [Github repo](https://github.com/artefactory/terraform-google-airbyte-infra)
* - [Terraform module registry](https://registry.terraform.io/modules/artefactory/airbyte-infra/google/latest)
*
* ## Prerequisites
*
* - Terraform. Tested with v1.5.3
* - A GCP project and an authenticated gcloud CLI
*
* ### Permissions
*
*   - Broad roles that will work, but **not recommended** for service accounts or even people.
*     - `roles/owner`
*   - Recommended roles to respect the least privilege principle.
*     - `roles/compute.admin`
*     - `roles/iam.serviceAccountAdmin`
*     - `roles/resourcemanager.projectIamAdmin`
*   - Granular permissions required to build a custom role specific for this deployment.
*     - `compute.addresses.create`
*     - `compute.addresses.delete`
*     - `compute.disks.create`
*     - `compute.firewalls.create`
*     - `compute.firewalls.delete`
*     - `compute.instances.create`
*     - `compute.instances.delete`
*     - `compute.instances.setMetadata`
*     - `compute.instances.setServiceAccount`
*     - `compute.networks.create`
*     - `compute.networks.delete`
*     - `compute.networks.updatePolicy`
*     - `compute.routers.create`
*     - `compute.routers.delete`
*     - `compute.routers.update`
*     - `compute.routes.create`
*     - `compute.routes.delete`
*     - `compute.subnetworks.create`
*     - `compute.subnetworks.delete`
*     - `compute.subnetworks.use`
*     - `iam.serviceAccounts.create`
*     - `iam.serviceAccounts.delete`
*     - `resourcemanager.projects.setIamPolicy`
*
* ## Usage
*
* [Go to the `examples` directory to view deployment code samples.](https://github.com/artefactory/terraform-google-airbyte-infra/tree/main/examples)
*
* Once deployment is successfully finished, you will need to SSH tunnel to your Airbyte instance:
*
* ```shell
* $ gcloud compute ssh airbyte -- -L 8000:localhost:8000 -N -f
* ```
*
* [You will then be able to access it via your browser](http://localhost:8000).
*
* You may also Terraform the ELT flows themselves using the [Artefactory terraform-google-airbyte-flows module](https://registry.terraform.io/modules/artefactory/airbyte-flows/google/latest), or the [Airbyte community provider](https://registry.terraform.io/providers/josephjohncox/airbyte/latest).
*
* ## Architecture
*
* This module will provision the following resources.
*
* ![](docs/archi.png)
*
* As a security precaution, the Airbyte VM is not reachable from the internet. The only way to access it is through gcloud-authenticated SSH. Egress traffic is of course possible to access remote data sources to pull data from.
*
* The Airbyte service account has fairly high level of privilege on GCS and BQ (`roles/storage.objectAdmin`, and `roles/bigquery.dataEditor`), allowing it to read/write on any table or bucket. These permissions are required to allow Airbyte to create temporary datasets and tables. If that is an issue for you, you can isolate this deployment in a dedicated project.
*
* --------
* ## Auto-generated module documentation
*
*/