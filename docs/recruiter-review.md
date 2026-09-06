# Recruiter / Hiring Manager Review Guide

## What this project demonstrates

**Cloud infrastructure:** Infrastructure as Code and reusable cloud/Kubernetes foundations.

**DevOps:** Automated validation, CI/CD concepts, Git-based change control and repeatable delivery.

**Platform engineering:** A golden-path model that turns lower-level infrastructure primitives into reusable application-team workflows.

**SRE:** SLO thinking, observability, incident response, disaster recovery and workload reliability controls.

**Security:** Policy-as-code, least privilege, network isolation and security checks integrated into delivery.

## Five-minute review path

1. Read the architecture and engineering story in `README.md`.
2. Review `terraform/` for Infrastructure as Code.
3. Review `.github/workflows/` for automated validation and self-service workflows.
4. Review `charts/` and `platform/` for Kubernetes/platform patterns.
5. Review `docs/` for architecture decisions, SLOs, incident response, DR and operational thinking.

## Interview topics this project supports

- Designing cloud platforms with Terraform and Kubernetes
- CI/CD and GitOps architecture
- Reliability and failure-mode design
- Kubernetes workload resilience
- Observability and SLOs
- Security controls in delivery pipelines
- Platform engineering and developer experience
- Disaster recovery and operational readiness

## Scope note

This is a portfolio/reference implementation intended to make engineering decisions and artifacts inspectable. It does not claim to represent a currently running customer production environment.