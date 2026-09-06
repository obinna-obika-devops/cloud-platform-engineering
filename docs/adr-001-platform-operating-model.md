# ADR-001: Platform Operating Model

- **Status:** Accepted
- **Date:** 2026-09-06
- **Decision:** Use declarative, policy-controlled, observable platform operations.

## Context

A cloud platform needs repeatable infrastructure changes, consistent workload deployment, security controls, and clear operational ownership.

## Decision

The reference platform follows these principles:

1. Infrastructure is managed as code with Terraform.
2. Kubernetes desired state is declarative and reconciled through GitOps patterns.
3. Security and policy checks run before deployment where practical.
4. Platform services expose health and telemetry for operational validation.
5. SLOs and error budgets guide reliability decisions.
6. Operational changes are reviewed, auditable, and designed to be reversible.
7. Runbooks and post-incident learning are maintained alongside engineering artifacts.

## Consequences

**Positive:** repeatability, auditability, safer changes, easier recovery, and clearer ownership boundaries.

**Trade-offs:** more upfront automation and documentation, plus the need to maintain policy and desired-state definitions.

## Alternatives Considered

- Manual console-driven operations: rejected because they are difficult to reproduce and audit.
- Uncontrolled imperative deployment: rejected because drift and rollback become harder to manage.

> This ADR documents the portfolio's reference operating model; it is not a claim of production operation.
