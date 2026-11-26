# Solution 02 — ImagePullBackOff

```bash
kubectl apply -f cka/05-troubleshooting/setup/02-imagepull.yaml
kubectl -n ts-pull describe pod bad-image
# Failed to pull image … not found
```

```bash
kubectl -n ts-pull delete pod bad-image
kubectl -n ts-pull run bad-image --image=nginx:1.25
```

Or `kubectl set image` on a Deployment — here the object is a bare Pod, so recreate/replace.
