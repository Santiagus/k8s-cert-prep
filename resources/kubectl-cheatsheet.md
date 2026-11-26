# kubectl cheat sheet (exam-oriented)

Official: [kubectl quick reference](https://kubernetes.io/docs/reference/kubectl/quick-reference/). Prefer `kubectl --help` and `kubectl explain` over memorizing schemas.

## Context & namespaces

```bash
kubectl config get-contexts
kubectl config use-context <name>
kubectl config set-context --current --namespace=<ns>
kubectl get ns
kubectl create ns <ns>
```

Always note the **namespace** in the question before creating objects.

## Imperative create (fast path)

```bash
kubectl run nginx --image=nginx:1.25 --restart=Never
kubectl create deployment web --image=nginx:1.25 --replicas=3
kubectl expose deployment web --port=80 --target-port=80 --name=web-svc
kubectl create job pi --image=perl:5.34 -- perl -Mbignum=bpi -wle 'print bpi(2000)'
kubectl create cronjob ping --image=busybox:1.36 --schedule="*/5 * * * *" -- /bin/sh -c 'date'
kubectl create configmap app-cfg --from-literal=APP_ENV=prod
kubectl create secret generic app-secret --from-literal=password=s3cret
kubectl create sa builder
kubectl create role pod-reader --verb=get,list --resource=pods -n <ns>
kubectl create rolebinding bob-pods --role=pod-reader --user=bob -n <ns>
kubectl create clusterrole node-reader --verb=get,list --resource=nodes
kubectl create clusterrolebinding bob-nodes --clusterrole=node-reader --user=bob
```

## Dry-run → edit → apply

```bash
kubectl create deployment web --image=nginx:1.25 --dry-run=client -o yaml > web.yaml
# edit web.yaml
kubectl apply -f web.yaml
```

## Scale, rollout, set

```bash
kubectl scale deployment web --replicas=5
kubectl set image deployment/web nginx=nginx:1.26
kubectl rollout status deployment/web
kubectl rollout history deployment/web
kubectl rollout undo deployment/web
kubectl autoscale deployment web --min=2 --max=5 --cpu-percent=80
```

## Inspect & debug

```bash
kubectl get po,svc,deploy,ing,netpol,pv,pvc,sc -A
kubectl get po -o wide
kubectl describe po <pod>
kubectl logs <pod> [-c <container>] [--previous]
kubectl exec -it <pod> -- /bin/sh
kubectl top nodes
kubectl top pods -n <ns>
kubectl get events -n <ns> --sort-by=.lastTimestamp
kubectl explain pod.spec.containers.resources
```

## Networking checks

```bash
kubectl get endpoints <svc>
kubectl get svc -o wide
kubectl run tmp --rm -it --restart=Never --image=busybox:1.36 -- wget -qO- http://web-svc.<ns>.svc.cluster.local
```

## Labels / taints / drain

```bash
kubectl label nodes <node> disk=ssd
kubectl taint nodes <node> key=value:NoSchedule
kubectl taint nodes <node> key=value:NoSchedule-   # remove
kubectl cordon <node>
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data
kubectl uncordon <node>
```

## Copy & edit

```bash
kubectl cp <ns>/<pod>:/path/file ./file
kubectl edit deploy web
kubectl replace --force -f pod.yaml   # last resort for immutable pods
```
