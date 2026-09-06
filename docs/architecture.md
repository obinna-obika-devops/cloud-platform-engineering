# Platform Architecture

## End-to-End Platform Flow

```mermaid
flowchart LR
    Dev[Developer] --> Git[GitHub Repository]
    Git --> CI[GitHub Actions]
    CI --> Sec[Security Gates\nTrivy / Checkov / Gitleaks]
    Sec --> Image[Container Image]
    CI --> TF[Terraform]
    TF --> AWS[AWS]
    AWS --> VPC[VPC]
    VPC --> EKS[EKS Cluster]
    Image --> EKS
    EKS --> Helm[Helm Applications]
    Helm --> GitOps[GitOps / Argo CD]
    EKS --> Obs[Observability]
    Obs --> Prom[Prometheus]
    Obs --> Graf[Grafana]
    Obs --> OTel[OpenTelemetry]
    EKS --> SRE[SLOs / Error Budgets]
    EKS --> Policy[Kyverno Policy Gates]
    SRE --> Ops[Incident Response / Runbooks]
    Ops --> Remed[Automated Remediation]
```

## Engineering Layers

```mermaid
flowchart TB
    L1[Developer Experience\nSelf-Service Workflows]
    L2[Delivery\nCI/CD + GitOps]
    L3[Platform\nKubernetes + Helm]
    L4[Infrastructure\nTerraform + AWS]
    L5[Reliability\nSLOs + Observability + DR]
    L6[Security\nPolicy-as-Code + Supply Chain]

    L1 --> L2 --> L3 --> L4
    L3 --> L5
    L3 --> L6
```

## Change Lifecycle

1. Developer proposes a change through Git.
2. CI validates code, infrastructure, and security controls.
3. Terraform manages infrastructure changes as code.
4. GitOps reconciles application configuration.
5. Kubernetes runs workloads with platform guardrails.
6. Observability measures service health and reliability objectives.
7. SRE controls guide incident response, remediation, and recovery.

> Portfolio/reference architecture. This diagram describes the engineering design represented by the repository and does not imply a live production deployment.