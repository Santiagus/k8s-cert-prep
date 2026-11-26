# Solution 02 — Minimal RBAC

```bash
kubectl create ns cks-hard 2>/dev/null || true
kubectl -n cks-hard create sa cm-reader
kubectl -n cks-hard create role cm-reader --verb=get,list --resource=configmaps
kubectl -n cks-hard create rolebinding cm-reader --role=cm-reader --serviceaccount=cks-hard:cm-reader
kubectl auth can-i get configmaps --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard  # yes
kubectl auth can-i create pods --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard     # no
```
