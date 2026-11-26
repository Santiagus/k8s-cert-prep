# Solution 04 — Dedicated SA, default unprivileged

```bash
kubectl -n cks-hard create sa app-sa
kubectl -n cks-hard create role app-cm --verb=get,list --resource=configmaps
kubectl -n cks-hard create rolebinding app-cm --role=app-cm --serviceaccount=cks-hard:app-sa

kubectl -n cks-hard run app --image=registry.k8s.io/pause:3.9 --restart=Never \
  --overrides='{"spec":{"serviceAccountName":"app-sa","automountServiceAccountToken":false}}'
```

```bash
kubectl auth can-i get configmaps --as=system:serviceaccount:cks-hard:app-sa -n cks-hard   # yes
kubectl auth can-i get configmaps --as=system:serviceaccount:cks-hard:default -n cks-hard  # no
```

Never bind ClusterRoles with write verbs to `default`.
