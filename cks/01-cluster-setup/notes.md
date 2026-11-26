# Cluster Setup (10%)

Competencies: NetworkPolicies for cluster access; CIS-style review of etcd/kubelet/DNS/API; Ingress TLS; protect node metadata/endpoints; verify platform binaries.

## Skill checklist

- [ ] Default-deny Ingress (and Egress) NetworkPolicies with empty `podSelector: {}`
- [ ] Allowlist Pod-to-Pod and namespace selectors; DNS egress (UDP/TCP 53)
- [ ] `ipBlock` / `except` to block link-local metadata (`169.254.169.254/32`) conceptually
- [ ] Ingress with TLS Secret (`kubernetes.io/tls`) and host routing
- [ ] kube-apiserver / kubelet / etcd hardening flags awareness (CIS — link only, no PDF paste)
- [ ] Protect dashboard / metrics endpoints; avoid anonymous admin
- [ ] Verify kubeadm/kubectl/kubelet checksums before install
- [ ] CNI must enforce NetworkPolicy (kindnet may not — Calico/Cilium for real effect)

## High-value commands

```bash
kubectl create ns secure
kubectl -n secure apply -f netpol.yaml
kubectl -n secure get netpol -o wide
kubectl explain networkpolicy.spec --recursive
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt -subj "/CN=secure.example.com"
kubectl -n secure create secret tls web-tls --cert=tls.crt --key=tls.key
# On control plane (kubeadm): inspect /etc/kubernetes/manifests/kube-apiserver.yaml
```

## Mental model

```
Client → Ingress (TLS terminate) → Service → Pods
Pods ↔ Pods gated by NetworkPolicy (CNI)
API / etcd / kubelet: CIS flags + network exposure
```

## Doc / tool links

- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Declare Network Policy](https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy/)
- [Ingress TLS](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)
- [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes) (do not paste proprietary text)
- [kubeadm certificates](https://kubernetes.io/docs/setup/best-practices/certificates/)
- [Secure a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/)
- More: [docs/sources.md](../../docs/sources.md), [resources/cks-tools.md](../../resources/cks-tools.md)

## Lab notes

- Practice objects on kind even when kindnet does not enforce; verify YAML with `kubectl get/describe`.
- Metadata IP drills are conceptual on kind (no cloud IMDS); still write correct `ipBlock` policies.
- Cross-link CKA networking: [cka/03-services-networking/](../../cka/03-services-networking/).

## Gaps

<!-- after practice -->
