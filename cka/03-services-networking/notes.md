# Services & Networking (20%)

Competencies: Pod connectivity; NetworkPolicy; Service types & Endpoints; Gateway API; Ingress; CoreDNS.

## Skill checklist

- [ ] ClusterIP / NodePort / LoadBalancer Services; Endpoints / EndpointSlices
- [ ] DNS names: `<svc>.<ns>.svc.cluster.local`
- [ ] Ingress resource + controller concepts
- [ ] Gateway API basics (GatewayClass / Gateway / HTTPRoute) — curriculum includes this
- [ ] NetworkPolicy: ingress/egress, podSelector, namespaceSelector, ipBlock
- [ ] CoreDNS ConfigMap troubleshooting (`kubectl -n kube-system edit cm coredns`)

## High-value commands

```bash
kubectl expose deploy/web --port=80 --target-port=80
kubectl get svc,endpoints,ing,netpol,gateway,httproute -A
kubectl run tmp --rm -it --restart=Never --image=busybox:1.36 -- nslookup kubernetes.default
kubectl -n kube-system get cm coredns -o yaml
```

## Doc links

- [Services](https://kubernetes.io/docs/concepts/services-networking/service/)
- [DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Declare Network Policy](https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy/)
- [Gateway API](https://gateway-api.sigs.k8s.io/)
- [Debugging DNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/)

## Lab notes

- kind: install an Ingress controller (e.g. ingress-nginx kind manifests) before Ingress drills.
- NetworkPolicy requires a supporting CNI — see [labs/kind-bootstrap/README.md](../../labs/kind-bootstrap/README.md).
- Gateway API: install CRDs + a controller (e.g. Envoy Gateway or nginx gateway fabric) for end-to-end; YAML authoring still valuable without full data plane.

## Gaps

<!-- after practice -->
