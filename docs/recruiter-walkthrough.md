# Recruiter / Interview Walkthrough

This page is a fast way to evaluate the engineering depth in this repository without reading every file.

## 5-minute review path

1. Start with `README.md` for the platform architecture and scope.
2. Review `terraform/` for the AWS/EKS infrastructure model and reusable infrastructure patterns.
3. Review `platform/` for cluster-wide policy, tenancy and GitOps bootstrap concerns.
4. Review `charts/` and `apps/` for the application delivery path.
5. Review `.github/workflows/ci.yml` for automated validation and security gates.
6. Review `docs/engineering-evidence.md` and the runbooks for operational depth.

## What this project proves

The project is designed to show more than infrastructure provisioning. It demonstrates how a platform engineer connects cloud infrastructure, Kubernetes, GitOps, CI/CD, security, observability and reliability into one controlled developer platform.

Key engineering themes:

- repeatable infrastructure with Terraform
- EKS-based Kubernetes platform design
- GitOps reconciliation and declarative delivery
- workload isolation and platform guardrails
- SLOs, monitoring and operational runbooks
- policy-as-code and supply-chain security controls
- disaster recovery and blast-radius reduction

## Good interview discussion points

### Why GitOps?
Git remains the desired-state source of truth, giving infrastructure and application changes a reviewable, auditable path. Reconciliation reduces configuration drift and makes rollback reasoning clearer.

### How is reliability built in?
The platform combines workload controls such as probes, HPA/PDB patterns and topology-aware scheduling with SLOs, alerting and runbooks. Reliability is treated as an operating model rather than a single tool.

### How is security handled?
The repository uses layered controls: CI scanning, Kubernetes policy, RBAC, network policy, immutable artifact patterns and short-lived identity approaches where applicable.

### What would change for a real production deployment?
A production implementation would add organization-specific IAM, remote Terraform state, environment-specific secrets management, approved registries, real DNS/TLS, centralized logging, production alert routing, cost controls and explicit change-management approvals.

## Validation commands

```bash
terraform -chdir=terraform fmt -check
terraform -chdir=terraform init -backend=false
terraform -chdir=terraform validate
helm lint charts/platform-service
```

Use the repository CI workflow as the primary automated validation path.

## Scope and integrity

This is a portfolio/reference implementation. It demonstrates production-minded engineering patterns, but it does not claim live customer traffic, active production AWS resources or business outcomes that are not explicitly evidenced in the repository.
