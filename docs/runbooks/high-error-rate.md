# High Error Rate Runbook

## Trigger

Alert fires when 5xx rate exceeds the service threshold for 10 minutes or the availability SLO burn rate is elevated.

## Triage

1. Check Grafana request rate, 5xx rate, latency and pod restarts.
2. Inspect Argo CD for a recent sync or drift event.
3. Check HPA desired/current replicas and node pressure.
4. Compare the incident start time with the latest deployment.

## Mitigation

- If a release caused the regression, stop promotion and revert the GitOps change.
- If capacity constrained, restore replicas/node capacity within the approved limits.
- If dependency failure is suspected, apply the documented fallback or isolate the dependency.

## Recovery

Verify error rate, latency and readiness return to normal. Record timeline, impact and contributing factors. Open a follow-up action for permanent remediation.
