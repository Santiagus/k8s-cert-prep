# Solution 03 — Empty Endpoints

```bash
kubectl apply -f cka/05-troubleshooting/setup/03-service-endpoints.yaml
kubectl -n ts-svc get endpoints store
# empty — Service selector app=storefront vs Pods app=store
```

Fix the Service selector:

```bash
kubectl -n ts-svc patch svc store -p '{"spec":{"selector":{"app":"store"}}}'
kubectl -n ts-svc get endpoints store
kubectl -n ts-svc run tmp --rm -it --restart=Never --image=busybox:1.36 -- wget -qO- http://store
```

**Failure modes:** Changing Pod labels without updating Deployment selector (immutable); patching the wrong field.
