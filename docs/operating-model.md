# Platform Operating Model

## Golden path

1. Developer opens a pull request with application code and deployment values.
2. CI validates Terraform, Helm and Kubernetes manifests and scans dependencies/images.
3. Merge updates desired state in Git.
4. Argo CD reconciles the target environment.
5. SLO dashboards and alerts provide operational feedback.

## Guardrails

- No plaintext secrets in Git.
- Workloads must declare resource requests/limits.
- `latest` image tags are rejected by policy.
- Team namespaces have quotas and default limits.
- Network traffic is deny-by-default at namespace level.
- Deployments use readiness/liveness checks and disruption budgets.
- Production changes are promoted through reviewable Git history.

## Cost controls

ResourceQuota and LimitRange prevent uncontrolled namespace growth. Autoscaling keeps capacity proportional to demand. Production node sizing should be reviewed against utilization and workload criticality rather than copied blindly from development.
