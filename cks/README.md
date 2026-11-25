# CKS

Certified Kubernetes Security Specialist prep. Domain weights from the [CNCF CKS page](https://www.cncf.io/training/certification/cks/) / [cncf/curriculum](https://github.com/cncf/curriculum) (verified Nov 2025). CKA is a prerequisite to sit CKS.

## Domains & weights

| # | Domain | Weight | Folder |
|---|--------|--------|--------|
| 01 | Cluster Setup | 10% | [01-cluster-setup/](01-cluster-setup/) |
| 02 | Cluster Hardening | 15% | [02-cluster-hardening/](02-cluster-hardening/) |
| 03 | System Hardening | 15% | [03-system-hardening/](03-system-hardening/) |
| 04 | Minimize Microservice Vulnerabilities | 20% | [04-minimize-microservice-vulns/](04-minimize-microservice-vulns/) |
| 05 | Supply Chain Security | 20% | [05-supply-chain/](05-supply-chain/) |
| 06 | Monitoring, Logging and Runtime Security | 20% | [06-monitoring-logging-runtime/](06-monitoring-logging-runtime/) |

## Topic index

- [01 Cluster Setup](01-cluster-setup/notes.md) — network policies, Ingress TLS, CIS benchmarks, secure API exposure
- [02 Cluster Hardening](02-cluster-hardening/notes.md) — RBAC, ServiceAccounts, API server / kubelet security
- [03 System Hardening](03-system-hardening/notes.md) — host OS, kernel modules, least privilege, IAM
- [04 Minimize Microservice Vulnerabilities](04-minimize-microservice-vulns/notes.md) — PSA, SecurityContext, Secrets, mTLS, sandboxing
- [05 Supply Chain Security](05-supply-chain/notes.md) — image provenance, scanning, SBOM, admission, signed artifacts
- [06 Monitoring, Logging & Runtime](06-monitoring-logging-runtime/notes.md) — audit logs, Falco, immutability, threat detection

Each topic has `notes.md`, `tasks/`, and `solutions/`.
