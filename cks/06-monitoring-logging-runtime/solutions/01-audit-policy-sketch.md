# Solution 01 — Audit policy sketch

```yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  - level: Metadata
    resources:
      - group: ""
        resources: ["secrets"]
  - level: RequestResponse
    resources:
      - group: ""
        resources: ["pods/exec"]
  - level: None
```

kube-apiserver (typical): `--audit-policy-file=…` and `--audit-log-path=…` — see [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/).
