# Solution 01 — automountServiceAccountToken

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: notoken
  namespace: cks-hard
spec:
  automountServiceAccountToken: false
  containers:
    - name: busybox
      image: busybox:1.36
      command: ["sleep", "3600"]
```

```bash
kubectl create ns cks-hard
kubectl apply -f /tmp/notoken.yaml
kubectl -n cks-hard exec notoken -- ls /var/run/secrets/kubernetes.io/serviceaccount
# fails — good
```
