# ADR-001: Platform Architecture

## Status
Accepted

## Decision
Use Kubernetes on Amazon EKS as the workload control plane, Terraform for infrastructure, GitHub Actions for validation/self-service requests, and Argo CD for continuous reconciliation.

## Why
This separates infrastructure provisioning from workload delivery, makes desired state reviewable in Git, and provides a consistent platform contract for application teams.

## Trade-offs
EKS and Argo CD add operational complexity, but they provide mature primitives for workload scheduling, reconciliation and multi-team isolation. The platform deliberately avoids hiding Kubernetes completely; developers still own application configuration and operational signals while the platform owns guardrails.
