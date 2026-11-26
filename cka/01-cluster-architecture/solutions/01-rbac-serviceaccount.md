# Solution 01 — RBAC for a deployer ServiceAccount

```bash
kubectl create ns rbac-lab
kubectl -n rbac-lab create sa deployer

kubectl -n rbac-lab create role deployer \
  --verb=get,list,watch,create,update,patch,delete \
  --resource=pods,deployments,deployments/scale

kubectl -n rbac-lab create rolebinding deployer \
  --role=deployer \
  --serviceaccount=rbac-lab:deployer

kubectl auth can-i create deployments --as=system:serviceaccount:rbac-lab:deployer -n rbac-lab
# yes
kubectl auth can-i create deployments --as=system:serviceaccount:rbac-lab:deployer -n default
# no
```

**Failure modes:** Binding the wrong SA namespace; using ClusterRole when the requirement is namespaced; forgetting `deployments` in `apps` API group — `kubectl create role` handles the API group for standard resources.
