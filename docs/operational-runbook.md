# Operational Runbook

## Purpose

This runbook defines the operating pattern for the reference cloud platform: detect, assess, mitigate, recover, and document.

## 1. Service Health

Check application health, Kubernetes pod state, deployment status, resource pressure, and recent changes.

```bash
kubectl get pods -A
kubectl get deploy -A
kubectl get events -A --sort-by=.lastTimestamp
```

## 2. High Error Rate

1. Confirm the alert and affected workload.
2. Check recent deployments and configuration changes.
3. Inspect application logs and HTTP error metrics.
4. Compare current traffic and saturation with the SLO/error-budget policy.
5. Roll back the most recent change when it is the confirmed cause.
6. Record the incident timeline and follow-up actions.

## 3. CrashLoopBackOff

1. Inspect pod events and container logs.
2. Validate configuration, secrets references, image version, and resource limits.
3. Compare against the last known healthy deployment.
4. Restore the last known-good version if appropriate.
5. Create a follow-up action for the underlying defect.

## 4. Latency Degradation

Check request latency, CPU/memory saturation, downstream dependencies, pod scaling, and recent infrastructure changes. Prefer reversible mitigation first.

## 5. Change Safety

Production-like changes should be small, observable, reversible, and reviewed. Do not bypass security or policy controls to restore service without documenting the exception.

## 6. Evidence

Capture timestamps, commands, alerts, relevant logs, deployment versions, decisions, and remediation results. Avoid storing secrets or credentials in incident records.

> Portfolio/reference runbook. It documents an engineering operating model and does not claim production deployment.
