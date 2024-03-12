# Contribution guide

Thank you for investing your time in contributing to this project!

## Issues

If you find a bug or want to suggest changes, feel free to open an issue on this repo if a related one does not already exist.

## Make changes

If you want to contribute to this module, you can clone the repo and open a PR with you suggested changes, and an explanation of the rationale behind them.

### Working locally

To quickly iterate, you can deploy the module without publishing it:

```bash
cd local_dev
```

```bash
export TF_VAR_project_id=<GCP project id>
export TF_VAR_region=<GCP resources region>
export TF_VAR_zone=<GCP resources zone>
```

```bash
terraform init
terraform apply
```

### Deploying a new version

Please make sure to go through this checklist before opening your PR:

- Document your changes
  - Add readme sections to explain your new features. Be careful though, the readme are auto-generated from the `main.tf` by the pre-commit hooks, so make sure to amend the right file or your changes will be overwritten.
  - Add code samples in `examples` if relevant.
- Run the pre-commit hooks: `pre-commit install && pre-commit run --all-files`. This will format the TF code and generate documentation.
- Tag your proposed changes with an RC tag (e.g. `0.1.6-rc.6`) in compliance with the [semver](http://semver.org) specification.
- Commit and push
- Run a final test on a sandbox using the version you just pushed: 
```hcl
module "my_module" {
  source  = "git::https://example.com/vpc.git?ref=0.1.6-rc.6"
}
```

After the feature is merged, create a new release with a definitive tag (e.g. `0.1.6`) so that it's available on the Terraform module registry.

## Chores How-to

### Bumping the Airbyte version

Unless something big happened, the only files you should need to change are in `airbyte_install`.

Grab the most recent ones from `https://github.com/airbytehq/airbyte-platform` and manually compare and merge the old and new versions. It is important the memory limits in `docker-compose.yaml` are there, but they can be raised.