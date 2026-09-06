# Terraform State and Environment Strategy

The Terraform root module is designed to keep environment configuration separate from remote state configuration.

## Remote state

The root module declares an S3 backend without hard-coded account-specific values. Operators provide backend settings at initialization time using a copy of `terraform/backend.hcl.example`.

Example:

```bash
cp terraform/backend.hcl.example terraform/backend.dev.hcl
terraform -chdir=terraform init -backend-config=backend.dev.hcl
terraform -chdir=terraform plan -var-file=environments/dev.tfvars
```

The state bucket and lock table are bootstrap dependencies and are intentionally not created by the same state they protect. In a real AWS account they should be provisioned separately with encryption, versioning, access logging, least-privilege IAM, and deletion protection appropriate to the environment.

Each environment should use a distinct state key, for example:

```text
cloud-platform-engineering/dev/terraform.tfstate
cloud-platform-engineering/staging/terraform.tfstate
cloud-platform-engineering/production/terraform.tfstate
```

This avoids sharing state across environments and reduces the blast radius of infrastructure changes.

## Environment values

Environment-specific values live under `terraform/environments/`:

- `dev.tfvars`
- `staging.tfvars`
- `production.tfvars`

The files use separate cluster names and non-overlapping VPC CIDRs. They contain no credentials or account secrets.

## Change flow

1. Select the backend configuration for the target environment.
2. Initialize Terraform against that environment's state.
3. Run formatting and validation.
4. Produce a plan using the corresponding `.tfvars` file.
5. Review the plan before apply.
6. Apply from an authenticated CI or operator context using short-lived AWS credentials.

Production state and production apply permissions should be isolated from lower environments even when the same Terraform modules are reused.
