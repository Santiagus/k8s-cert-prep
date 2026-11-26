# Troubleshooting (30%)

Highest CKA weight. Competencies: clusters & nodes; cluster components; resource usage; container output streams; services & networking failures.

## Skill checklist

- [ ] Node NotReady: kubelet, runtime, disk pressure, network
- [ ] Control plane static Pods under `/etc/kubernetes/manifests`
- [ ] API server / etcd / scheduler / controller-manager health
- [ ] `kubectl describe` + Events; `kubectl logs` / `--previous`
- [ ] CrashLoopBackOff, ImagePullBackOff, Pending (scheduling)
- [ ] Service with empty Endpoints (selector mismatch)
- [ ] DNS failures vs app failures
- [ ] `kubectl top` (needs metrics-server)
- [ ] Cordon / drain / uncordon during node work

## Triage order (exam)

1. Namespace + object names from the question  
2. `get` / `describe` / Events  
3. `logs` (+ `--previous`)  
4. `exec` / DNS / Service Endpoints  
5. Node / component level if cluster-scoped  

## High-value commands

```bash
kubectl get nodes -o wide
kubectl describe node <n>
kubectl get pods -A -o wide | grep -v Running
kubectl describe pod <p> -n <ns>
kubectl logs <p> -n <ns> --previous
kubectl get endpoints <svc> -n <ns>
kubectl top nodes
kubectl top pods -A
# on control plane host:
sudo crictl ps | head
sudo journalctl -u kubelet -n 100 --no-pager
```

## Doc links

- [Debug applications](https://kubernetes.io/docs/tasks/debug/debug-application/)
- [Debug clusters](https://kubernetes.io/docs/tasks/debug/debug-cluster/)
- [Debug Services](https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/)
- [Resource metrics pipeline](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/)

## Gaps

<!-- after practice -->
