# Solution 05 — Expanded audit policy

```yaml
apiVersion: audit.k8s.io/v1
kind: Policy
omitStages: ["RequestReceived"]
rules:
  - level: Metadata
    resources:
      - group: ""
        resources: ["secrets"]
  - level: RequestResponse
    resources:
      - group: ""
        resources: ["pods/exec", "pods/portforward"]
  - level: None
    users: ["system:kube-proxy"]
  - level: Metadata
    omitStages: ["RequestReceived"]
```

Flags: `--audit-policy-file=/etc/kubernetes/audit-policy.yaml` `--audit-log-path=/var/log/kubernetes/audit.log` (paths vary). See [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/).
