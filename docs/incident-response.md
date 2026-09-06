# Incident Response

## Incident Lifecycle

**Detect → Triage → Mitigate → Recover → Validate → Communicate → Learn**

## Severity Model

| Severity | Example | Initial focus |
|---|---|---|
| SEV-1 | Broad service outage or critical security event | Restore service and establish incident command |
| SEV-2 | Major degradation affecting an important workload | Mitigate impact and identify the failure domain |
| SEV-3 | Limited degradation or non-critical failure | Resolve safely during normal operations |

## Triage Checklist

- What is broken?
- When did it start?
- What changed immediately before the event?
- Which workloads, environments, or dependencies are affected?
- Is the SLO at risk?
- Is there a safe rollback or mitigation?

## Roles

- **Incident Commander:** coordinates decisions and priorities.
- **Technical Lead:** drives diagnosis and remediation.
- **Communications Lead:** maintains stakeholder updates.
- **Scribe:** records timeline, evidence, and decisions.

## Recovery

Prefer reversible actions. After mitigation, validate service health, error rate, latency, capacity, and deployment state before closing the incident.

## Post-Incident Review

Document impact, timeline, root/contributing causes, detection quality, response effectiveness, corrective actions, and owners. Focus on systems and process rather than blame.

> Portfolio/reference incident-response model; no production incident is claimed.
