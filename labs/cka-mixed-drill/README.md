# Lab: CKA mixed drill

Timed multi-domain practice after you have worked domain `tasks/` individually.

| | |
|--|--|
| **Timebox** | 45 minutes |
| **Domains** | Workloads & Scheduling, Services & Networking, Storage |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |

## Goal

Bring up a small app stack that meets all success criteria below. Do **not** open `solution/` until the timer ends.

## Starting state

- Empty namespaces (create what you need).
- kind cluster Ready with default StorageClass from bootstrap.

## Requirements

1. Namespace `drill`.
2. Deployment `shop` with **2** replicas of `nginx:1.25`, resource **requests** `cpu: 50m` / `memory: 64Mi`.
3. ConfigMap `shop-cfg` with key `SHOP_MODE=sale` injected as an environment variable into the containers.
4. ClusterIP Service `shop` exposing port **80**.
5. PVC `shop-data` (1Gi, ReadWriteOnce) mounted read-write at `/data` in the Pods (use a volume name of your choosing). With multiple replicas and RWO, expect scheduling constraints — document how you handled it (e.g. scale to 1 for the PVC mount path, or use an emptyDir for one replica and PVC on a single-replica Deployment). Prefer a **single-replica** Deployment if you mount the RWO PVC.
6. NetworkPolicy `shop-allow-dns` that allows egress DNS (UDP/TCP 53) and egress to the `shop` pods' own Service port from pods labeled `app=shop`, and denies other egress if your CNI enforces policy. If using default kindnet without policy enforcement, still write a correct policy and note CNI limits.

Clarify for this lab: use **1 replica** when mounting the RWO PVC to avoid multi-attach issues.

## Success criteria

```bash
kubectl -n drill get deploy shop
kubectl -n drill get svc shop
kubectl -n drill get pvc shop-data
kubectl -n drill exec deploy/shop -- printenv SHOP_MODE   # expect: sale
kubectl -n drill exec deploy/shop -- ls /data
```

## After the timer

Compare approach with [solution/](solution/). Capture misses in domain `notes.md`.
