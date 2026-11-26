# Solution 05 — Affinity and taints

```bash
NODE=$(kubectl get nodes -l '!node-role.kubernetes.io/control-plane' -o jsonpath='{.items[0].metadata.name}')
echo "Using worker: $NODE"

kubectl label node "$NODE" disk=ssd --overwrite
kubectl taint node "$NODE" dedicated=storage:NoSchedule

kubectl create ns sched-lab
```

Pod manifest:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ssd-pod
  namespace: sched-lab
spec:
  tolerations:
    - key: dedicated
      operator: Equal
      value: storage
      effect: NoSchedule
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: disk
                operator: In
                values: ["ssd"]
  containers:
    - name: nginx
      image: nginx:1.25
```

```bash
kubectl apply -f /tmp/ssd-pod.yaml
kubectl -n sched-lab get pod ssd-pod -o wide

# cleanup
kubectl taint node "$NODE" dedicated=storage:NoSchedule-
# optional: kubectl label node "$NODE" disk-
```

**Failure modes:** Tainting the only schedulable node without toleration on the Pod; using `Prefer` affinity when the task requires required; forgetting cleanup taint for later labs.
