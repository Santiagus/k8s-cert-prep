# Workloads & Scheduling (15%)

Competencies: Deployments (rollout/rollback); ConfigMaps & Secrets; autoscaling; self-healing primitives; Pod admission & scheduling (limits, affinity, etc.).

## Skill checklist

- [ ] Deployments: create, scale, `set image`, rollout history / undo
- [ ] Jobs / CronJobs
- [ ] ConfigMaps & Secrets as env and volumes
- [ ] Probes: liveness, readiness, startup
- [ ] Requests / limits; LimitRange / ResourceQuota awareness
- [ ] HPA (`kubectl autoscale` / `autoscaling/v2`)
- [ ] nodeSelector, nodeAffinity, podAffinity/AntiAffinity
- [ ] taints & tolerations
- [ ] DaemonSet awareness (when to use)

## High-value commands

```bash
kubectl create deployment web --image=nginx:1.25 --replicas=3
kubectl set image deploy/web nginx=nginx:1.26
kubectl rollout undo deploy/web
kubectl scale deploy/web --replicas=5
kubectl autoscale deploy/web --min=2 --max=6 --cpu-percent=70
kubectl create configmap … / secret …
kubectl taint nodes <n> sku=gpu:NoSchedule
```

## Doc links

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/) / [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
- [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/) / [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- [Probe configuration](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [Resource management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
- [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
- [Assigning Pods to nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
- [Taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

## Exam tips

- Metrics Server required for real HPA CPU metrics — kind may need metrics-server installed for HPA to scale; task solutions note this.
- Prefer imperative Deployment create + dry-run for probes/affinity edits.

## Gaps

<!-- after practice -->
