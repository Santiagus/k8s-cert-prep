# Solution 02 — Secret volume

```bash
kubectl -n cks-psa create secret generic db-pass --from-literal=password=changeme
kubectl -n cks-psa run secret-pod --image=busybox:1.36 --dry-run=client -o yaml --command -- sleep 3600 > /tmp/sp.yaml
# add volumeMount + secret volume; apply
```
