# Production Cloud Platform Engineering

<p align="center"><strong>A reference Internal Developer Platform on AWS EKS</strong></p>

<p align="center">
<a href="https://github.com/obinna-obika-devops/cloud-platform-engineering/actions/workflows/ci.yml"><img src="https://github.com/obinna-obika-devops/cloud-platform-engineering/actions/workflows/ci.yml/badge.svg" alt="Platform CI"></a>
<img src="https://img.shields.io/badge/AWS-EKS-orange?logo=amazonaws" alt="AWS EKS">
<img src="https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform" alt="Terraform">
<img src="https://img.shields.io/badge/Kubernetes-Platform-326CE5?logo=kubernetes" alt="Kubernetes">
<img src="https://img.shields.io/badge/GitOps-Argo%20CD-EF7B4D?logo=argo" alt="GitOps">
<img src="https://img.shields.io/badge/Security-Policy--as--Code-blue" alt="Security">
</p>

A production-style reference implementation of an internal developer platform on AWS EKS. The platform turns infrastructure and Kubernetes primitives into a controlled self-service path while emphasizing reliability, security, observability, least privilege, and repeatable operations.

## Architecture

```mermaid
flowchart TD
    A[Developers / Teams] --> B[GitHub Actions]
    B --> C[Tests / Validation / Security Scan]
    C --> D[GitOps Desired State]
    D --> E[Argo CD]
    E --> F[AWS EKS]
    F --> G[Application Workloads]
    F --> H[Prometheus Metrics]
    F --> I[Kyverno / RBAC / Network Policies]
    F --> J[IRSA / OIDC Workload Identity]
    H --> K[SLOs / Alerts / Runbooks]
    I --> L[Security & Governance]
    J --> L
```

## Evidence at a glance

| Engineering area | Inspectable evidence |
|---|---|
| Cloud foundation | [`terraform/`](terraform/) |
| Remote state & environments | [`docs/terraform-state-and-environments.md`](docs/terraform-state-and-environments.md) |
| Workload identity | [`terraform/modules/irsa/`](terraform/modules/irsa/) |
| Kubernetes platform | [`platform/`](platform/) |
| Reusable application delivery | [`charts/`](charts/) + [`apps/`](apps/) |
| Application observability | [`apps/platform-demo/app.py`](apps/platform-demo/app.py) |
| CI validation | [`.github/workflows/ci.yml`](.github/workflows/ci.yml) |
| Architecture and design | [`docs/architecture.md`](docs/architecture.md) |
| SRE and operations | [`docs/runbooks/`](docs/runbooks/) |
| Engineering decisions | [`docs/adr/`](docs/adr/) |
| Capability-to-code map | [`docs/engineering-evidence.md`](docs/engineering-evidence.md) |

## Engineering model

**Developers** submit changes → **GitHub Actions** validates Terraform, Helm, manifests, application tests and source security → **Argo CD** reconciles desired state → **EKS** runs the workload → **Prometheus metrics, SLOs, policies, quotas, RBAC and network controls** make the platform observable and governable.

## Demonstrated capabilities

- AWS VPC + private-endpoint EKS foundation with Terraform
- KMS encryption for Kubernetes secrets and EKS control-plane logging
- Remote-state backend pattern with environment-specific state isolation
- Reusable Terraform modules and dev/staging/production configuration
- EKS OIDC provider plus reusable IRSA workload-identity module
- GitOps reconciliation with Argo CD project boundaries and retry controls
- Kubernetes multi-tenancy with namespaces, RBAC, quotas, limits and default-deny networking
- Restricted Pod Security admission and hardened workload security contexts
- Self-service environment requests with validation, concurrency protection and audit context
- HPA, PDB, rolling updates and topology-aware scheduling
- Prometheus application metrics and scrape discovery
- SLO/error-budget definitions and incident runbooks
- Kyverno policy-as-code controls
- Docker image build, application tests, Terraform/Helm validation and Trivy scanning in CI
- Disaster-recovery and platform operating procedures

## Engineering documentation

- [Engineering Evidence](docs/engineering-evidence.md) — maps platform capabilities to inspectable artifacts
- [Architecture](docs/architecture.md) — system design and platform boundaries
- [Terraform State & Environments](docs/terraform-state-and-environments.md) — remote-state and environment strategy
- [Workload Identity & Observability](docs/workload-identity-and-observability.md) — IRSA and metrics design
- [Operational Runbook](docs/operational-runbook.md) — operational procedures
- [Incident Response](docs/incident-response.md) — incident handling workflow
- [Disaster Recovery](docs/disaster-recovery.md) — recovery planning and validation
- [Platform Operating Model ADR](docs/adr-001-platform-operating-model.md) — engineering decision record
- [CI Workflow](.github/workflows/ci.yml) — automated infrastructure, application and security validation

## Technology

| Domain | Stack |
|---|---|
| Cloud | AWS, EKS, VPC |
| IaC | Terraform, S3 remote-state pattern |
| Identity | IAM, EKS OIDC, IRSA |
| Containers | Docker, Kubernetes, Helm |
| Delivery | GitHub Actions, Argo CD, GitOps |
| Observability | Prometheus instrumentation and scrape discovery |
| Security | Kyverno, RBAC, NetworkPolicy, Pod Security, Trivy |
| Reliability | SLOs, error budgets, PDB, HPA, topology spread, DR |

## Repository map

```text
terraform/       AWS/EKS foundation, environment values and IRSA module
platform/        cluster policies, tenancy controls and GitOps definitions
charts/          reusable application Helm chart
apps/            instrumented example service and tests
.github/         CI and self-service workflows
docs/            architecture, SLOs, runbooks, state strategy and ADRs
```

## Local validation

```bash
terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform init -backend=false
terraform -chdir=terraform validate
helm lint charts/platform-service
python -m pip install -r apps/platform-demo/requirements.txt
python -m unittest discover -s apps/platform-demo/tests -p "test_*.py"
```

For an AWS deployment, initialize Terraform with an environment-specific backend configuration and use short-lived AWS credentials. Never commit credentials or backend secrets.

## Scope

This is a reference implementation. It contains no cloud credentials and does not claim currently running AWS infrastructure, a connected Prometheus installation, or production traffic unless an operator explicitly deploys those components.
