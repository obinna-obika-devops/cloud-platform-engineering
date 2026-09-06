# Platform Architecture

See `architecture-overview.svg` for the visual architecture and the repository README for the high-level engineering flow.

## Core flow

Developer change → GitHub → CI validation → Terraform / GitOps → AWS + Kubernetes → workloads → security + observability → SRE operations → feedback.

## Design principles

- Infrastructure as code and automated validation.
- Git as the declarative source of truth.
- Kubernetes guardrails for access, resources, networking, and policy.
- Observability tied to SLOs and error budgets.
- Security integrated into delivery.
- Operational feedback drives continuous improvement.

> Portfolio/reference architecture. It does not claim a production deployment.