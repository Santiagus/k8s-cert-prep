# Solution 03 — Secret reader RBAC

```bash
kubectl create ns cks-hard --dry-run=client -o yaml | kubectl apply -f -
kubectl -n cks-hard create sa secret-reader
kubectl -n cks-hard create role secret-reader --verb=get,list --resource=secrets
kubectl -n cks-hard create rolebinding secret-reader --role=secret-reader --serviceaccount=cks-hard:secret-reader

kubectl auth can-i get secrets --as=system:serviceaccount:cks-hard:secret-reader -n cks-hard  # yes
kubectl auth can-i list pods --as=system:serviceaccount:cks-hard:secret-reader -n cks-hard    # no
```
