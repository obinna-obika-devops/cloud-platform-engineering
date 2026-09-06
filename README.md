# Production Cloud Platform Engineering

<p align="center"><strong>A reference Internal Developer Platform on AWS EKS</strong></p>

<p align="center">
<img src="https://img.shields.io/badge/AWS-EKS-orange?logo=amazonaws" alt="AWS EKS">
<img src="https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform" alt="Terraform">
<img src="https://img.shields.io/badge/Kubernetes-Platform-326CE5?logo=kubernetes" alt="Kubernetes">
<img src="https://img.shields.io/badge/GitOps-Argo%20CD-EF7B4D?logo=argo" alt="GitOps">
<img src="https://img.shields.io/badge/Security-Policy--as--Code-blue" alt="Security">
</p>

A production-style reference implementation of an internal developer platform on AWS EKS. The platform turns infrastructure and Kubernetes primitives into a safe self-service path for application teams while enforcing reliability, security, observability, and operational standards.

## Architecture

```mermaid
flowchart TD
    A[Developers / Teams] --> B[GitHub Actions]
    B --> C[Tests / Security Gates]
    C --> D[GitOps Manifests]
    D --> E[Argo CD]
    E --> F[AWS EKS]
    F --> G[Application Workloads]
    F --> H[Prometheus / Grafana]
    F --> I[OpenTelemetry]
    F --> J[Kyverno / RBAC / Network Policies]
    H --> K[SLOs / Alerts / Runbooks]
    I --> K
    J --> L[Security & Governance]
```

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

## Engineering Evidence

Want to verify the engineering depth instead of only reading the feature list? Start here:

- [Engineering Evidence](docs/engineering-evidence.md) — maps platform claims to inspectable artifacts
- [Architecture](docs/architecture.md) — system design and platform boundaries
- [Operational Runbook](docs/runbooks/operational-runbook.md) — operational procedures
- [Incident Response](docs/runbooks/incident-response.md) — incident handling workflow
- [Disaster Recovery](docs/runbooks/disaster-recovery.md) — recovery planning and validation
- [Platform Operating Model ADR](docs/adr/ADR-001-platform-operating-model.md) — engineering decision record
- [CI Workflow](.github/workflows/ci.yml) — automated infrastructure, application, and security validation

## Technology

| Domain | Stack |
|---|---|
| Cloud | AWS, EKS, VPC |
| IaC | Terraform |
| Containers | Docker, Kubernetes, Helm |
| Delivery | GitHub Actions, Argo CD, GitOps |
| Observability | Prometheus, Grafana, OpenTelemetry |
| Security | Kyverno, Trivy, Checkov, Gitleaks |
| Reliability | SLOs, error budgets, PDB, HPA, DR |

## Repository map

```text
terraform/       AWS/EKS platform foundation
platform/        cluster-wide policies and GitOps bootstrap
charts/          reusable application Helm chart
apps/            example production-style service
.github/         CI and self-service workflows
docs/            architecture, SLOs, runbooks and ADRs
```

## Quick start

```bash
terraform -chdir=terraform fmt -check
terraform -chdir=terraform init
terraform -chdir=terraform validate
helm lint charts/platform-service
```

For a real AWS deployment, provide credentials through CI identity federation or a local AWS profile and supply the required Terraform variables. Never commit credentials.

## Production engineering notes

This project is designed to be discussed in an interview: explain trade-offs, failure modes, reconciliation, blast-radius reduction, workload isolation, error budgets, least privilege, and how platform abstractions reduce cognitive load without hiding operational reality.

## Scope

**Status:** portfolio/reference implementation. The repository contains no cloud credentials, private keys, or claims of currently running AWS resources unless explicitly provisioned by an operator.
