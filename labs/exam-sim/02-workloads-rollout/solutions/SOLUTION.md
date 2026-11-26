# Solution — 02 workloads rollout

## Diagnose

```bash
kubectl -n sim-wl get deploy,pods
kubectl -n sim-wl describe pod -l app=shop | head -80
# ImagePullBackOff on nginx:1.25-does-not-exist; replicas=1; no SHOP_MODE
```

## Fix

```bash
kubectl -n sim-wl set image deploy/shop nginx=nginx:1.25
kubectl -n sim-wl scale deploy/shop --replicas=3
kubectl -n sim-wl set env deploy/shop SHOP_MODE-
kubectl -n sim-wl patch deploy shop --type=json -p='[
  {"op":"add","path":"/spec/template/spec/containers/0/env","value":[
    {"name":"SHOP_MODE","valueFrom":{"configMapKeyRef":{"name":"shop-cfg","key":"MODE"}}}
  ]}
]'
kubectl -n sim-wl rollout status deploy/shop --timeout=120s
```

If `env` already exists, prefer edit / replace via dry-run YAML:

```bash
kubectl -n sim-wl get deploy shop -o yaml > /tmp/shop.yaml
# set image nginx:1.25, replicas: 3, and:
# env:
# - name: SHOP_MODE
#   valueFrom:
#     configMapKeyRef:
#       name: shop-cfg
#       key: MODE
kubectl -n sim-wl apply -f /tmp/shop.yaml
```

## Verify

```bash
./labs/exam-sim/02-workloads-rollout/verify.sh
kubectl -n sim-wl exec deploy/shop -- printenv SHOP_MODE
```
