# Engineering Evidence

This page maps the repository's engineering practices to concrete artifacts that recruiters and reviewers can inspect.

## Architecture & Platform Design

- [Architecture](architecture.md) — platform topology, infrastructure boundaries, Kubernetes platform design, and engineering tradeoffs.
- [ADR-001: Platform Operating Model](adr/ADR-001-platform-operating-model.md) — documented decision-making around platform ownership and operating practices.

## Infrastructure as Code

- Terraform configuration under `terraform/` demonstrates reusable cloud infrastructure patterns.
- CI validates Terraform formatting, initialization, and configuration validity.

## Kubernetes & Platform Engineering

- Kubernetes manifests demonstrate RBAC, resource governance, network controls, and workload reliability patterns.
- Helm provides an application packaging path.
- GitOps artifacts demonstrate declarative deployment and environment promotion concepts.
- Self-service workflow artifacts demonstrate a platform-oriented developer experience.

## Reliability Engineering

- [Operational Runbook](runbooks/operational-runbook.md) — operational checks and response guidance.
- [Incident Response](runbooks/incident-response.md) — incident handling and escalation workflow.
- [Disaster Recovery](runbooks/disaster-recovery.md) — recovery planning and validation approach.
- SLO and error-budget artifacts define reliability objectives and operational decision points.
- HPA and PDB configuration demonstrates workload availability and scaling controls.

## Security & Policy

- Kyverno policies demonstrate policy-as-code and admission control concepts.
- Kubernetes RBAC and NetworkPolicies demonstrate identity and network isolation.
- Trivy provides filesystem security scanning in CI.
- Terraform and Helm validation create automated quality gates before changes are accepted.

## Testing & CI/CD

The GitHub Actions workflow validates:

1. Terraform formatting and validation
2. Helm chart linting
3. Container image buildability
4. Platform demo application unit tests
5. Filesystem vulnerability scanning with Trivy

Application tests cover `/`, `/healthz`, and `/readyz` behavior.

## Engineering Workflow

The repository also includes a pull-request workflow with validation, security, rollback, observability, and documentation expectations. See the repository's PR and issue templates for the review model.

## Portfolio Scope

This repository is a reference implementation designed to demonstrate engineering judgment and platform practices. It is not presented as evidence of a specific customer's production environment.
