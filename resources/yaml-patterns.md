# YAML patterns

Generate, then trim. Do not hand-write boilerplate under time pressure.

## Generate

```bash
kubectl run nginx --image=nginx:1.25 --restart=Never --dry-run=client -o yaml
kubectl create deployment web --image=nginx:1.25 --dry-run=client -o yaml
kubectl expose deployment web --port=80 --dry-run=client -o yaml
kubectl create rolebinding … --dry-run=client -o yaml
```

`kubectl explain <resource>.<field>` fills gaps (e.g. `kubectl explain netpol.spec`).

## Objects usually needing YAML (not pure imperative)

- NetworkPolicy
- Ingress / Gateway API resources
- PersistentVolume / StorageClass (often)
- Pod with affinity, tolerations, volume mounts, probes, securityContext
- ResourceQuota / LimitRange
- Multi-container Pods

## Minimal ResourceQuota example shape

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: team-a
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 2Gi
    limits.cpu: "4"
    limits.memory: 4Gi
    pods: "10"
```

## Minimal NetworkPolicy shape (deny ingress except from a label)

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend
  namespace: shop
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes: [Ingress]
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: frontend
      ports:
        - protocol: TCP
          port: 80
```

CNI must enforce NetworkPolicy (kind bootstrap notes which CNIs do).

## ConfigMap / Secret mounts

Prefer imperative create for the Secret/ConfigMap, then patch the Pod/Deployment with volume mounts via dry-run YAML or `kubectl set env` / `kubectl create … --from-file` as appropriate.

```bash
kubectl set env deployment/web --from=configmap/app-cfg
```
