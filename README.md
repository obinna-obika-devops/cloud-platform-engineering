# Production Cloud Platform Engineering

A recruiter-grade reference implementation of an internal developer platform on AWS EKS. The platform turns infrastructure and Kubernetes primitives into a safe self-service path for application teams while enforcing reliability, security, observability, and operational standards.

## Engineering story

**Developers** submit an application definition → **GitHub Actions** validates and packages it → **Argo CD** reconciles desired state → **EKS** runs the workload → **Prometheus/Grafana/OpenTelemetry** provide telemetry → **SLOs, policies, quotas, RBAC and security controls** protect the platform.

## Demonstrated capabilities

- AWS VPC + EKS foundation with Terraform
- Reusable infrastructure modules and environment separation
- GitOps with Argo CD
- Kubernetes multi-tenancy primitives: namespaces, RBAC, quotas, limits, network policies
- Self-service deployment workflow
- Helm application packaging
- HPA, PDB and topology-aware scheduling
- Prometheus/Grafana observability and OpenTelemetry instrumentation
- SLO/error-budget definitions and incident runbooks
- Kyverno policy-as-code
- Trivy, Checkov and Gitleaks security gates
- Supply-chain controls and immutable image references
- Disaster recovery and platform operating model
- Cost guardrails and resource governance

## Repository map

```text
terraform/       AWS/EKS platform foundation
platform/        cluster-wide policies and GitOps bootstrap
charts/          reusable application Helm chart
apps/            example production-style service
.github/         CI and self-service workflows
docs/            architecture, SLOs, runbooks and ADRs
```

## Deployment model

`dev → staging → production` is represented through GitOps manifests. The repository is intentionally safe to run as a reference implementation: it contains no cloud credentials, private keys, or claims of currently running AWS resources.

## Quick start

```bash
terraform -chdir=terraform fmt -check
terraform -chdir=terraform init
terraform -chdir=terraform validate
helm lint charts/platform-service
```

For a real AWS deployment, provide credentials through your CI identity federation or local AWS profile and supply the required Terraform variables. Never commit credentials.

## Architecture

```text
                    +----------------------+
                    | Developers / Teams   |
                    +----------+-----------+
                               |
                        Pull Request / CLI
                               v
                    +----------------------+
                    | GitHub Actions       |
                    | test/scan/build      |
                    +----------+-----------+
                               |
                         GitOps manifests
                               v
                    +----------------------+
                    | Argo CD              |
                    | reconciliation       |
                    +----------+-----------+
                               |
                               v
      +------------------------------------------------+
      | AWS EKS                                       |
      |                                                |
      | namespaces / RBAC / quotas / network policies |
      | workloads / HPA / PDB / ingress                |
      +-------------+----------------+-----------------+
                    |                |
             telemetry          metrics/logs
                    |                |
                    v                v
              OpenTelemetry   Prometheus/Grafana
```

## Production engineering notes

This project is designed to be discussed in an interview: explain trade-offs, failure modes, reconciliation, blast-radius reduction, workload isolation, error budgets, least privilege, and how platform abstractions reduce cognitive load without hiding operational reality.

**Status:** portfolio/reference implementation. AWS resources are not claimed as live unless explicitly provisioned by the operator.
