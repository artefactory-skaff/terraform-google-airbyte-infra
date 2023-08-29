/*
* # terraform-google-airbyte-flows
*
* A Terraform module to deploy an Airbyte server on a GCP compute engine instance.
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
* To the `examples` directory to view deployment code samples.
*
* ## Architecture
*
* ![](docs/archi.png)
*
* --------
* ## Auto-generated module documentation
*
*/