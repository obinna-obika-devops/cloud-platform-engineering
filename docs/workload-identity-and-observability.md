# Workload Identity and Observability

## EKS workload identity

The EKS module creates an IAM OIDC provider from the cluster issuer. The reusable `terraform/modules/irsa` module can then create a role whose trust policy is restricted to one Kubernetes namespace and service account.

The Helm chart exposes `serviceAccount.roleArn`. When an IRSA role is provisioned, pass the resulting role ARN as a Helm value so the service account receives the `eks.amazonaws.com/role-arn` annotation.

Example Terraform module usage:

```hcl
module "platform_demo_irsa" {
  source = "./modules/irsa"

  role_name            = "platform-demo"
  oidc_provider_arn    = module.eks.oidc_provider_arn
  oidc_issuer_url      = module.eks.oidc_issuer_url
  namespace            = "team-platform"
  service_account_name = "platform-demo"
  policy_arns          = []
}
```

Attach only policies required by the workload. An empty policy list intentionally produces an identity with no AWS data-plane permissions rather than granting broad access by default.

## Application metrics

The sample service exposes Prometheus metrics at `/metrics` using `prometheus-client`.

Implemented signals include:

- `platform_demo_http_requests_total`
- `platform_demo_http_request_duration_seconds`

The Helm Service adds Prometheus discovery annotations when metrics are enabled. This keeps application instrumentation in the workload while allowing the platform monitoring stack to own scraping, retention, alerting, and dashboarding.

Health and readiness endpoints remain separate from metrics:

- `/healthz`
- `/readyz`
- `/metrics`

## Operating boundary

This repository provides the instrumented workload, Kubernetes discovery metadata, and workload-identity primitives. It does not claim that a live Prometheus/Grafana installation or AWS account is currently connected unless an operator deploys those components explicitly.
