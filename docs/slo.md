# Platform SLOs

| Objective | Target | Window |
|---|---:|---|
| Availability | 99.9% | 30 days |
| Successful requests | 99.5% | 30 days |
| p95 latency | < 500 ms | 30 days |
| Deployment reconciliation | 99% within 10 min | 30 days |

A 99.9% monthly availability SLO gives roughly 43m 12s of error budget in a 30-day month. When the budget is exhausted, reliability work takes priority over risky feature promotion.

Track deployment failure rate, MTTR, change failure rate, pod restart rate, HPA saturation, node pressure, API errors, and GitOps drift.
