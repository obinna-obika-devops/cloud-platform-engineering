# Architecture Map

```text
Developer
   │
   ▼
GitHub ──► CI Validation ──► Terraform ──► AWS / Kubernetes
   │                              │              │
   └──────────────► GitOps ───────┘              │
                                                ▼
                                         Application Workloads
                                           │            │
                                      Security     Observability
                                           │            │
                                           └─────┬──────┘
                                                 ▼
                                         SRE / Operations
                                                 │
                                                 ▼
                                          Feedback to Git
```

See `architecture-overview.svg` for the polished visual version.