# Cluster Setup (10%)

Competencies: NetworkPolicies for cluster access; CIS-style review of etcd/kubelet/DNS/API; Ingress TLS; protect node metadata/endpoints; verify platform binaries.

## Skill checklist

- [ ] Default-deny + allow NetworkPolicies (namespace and Pod selectors)
- [ ] Ingress with TLS Secret (`kubernetes.io/tls`)
- [ ] kube-apiserver / kubelet / etcd hardening flags awareness (CIS)
- [ ] Block instance metadata endpoints (cloud) conceptually; NetworkPolicy/ipBlock drills on lab
- [ ] Verify kubeadm/kubectl/kubelet checksums before install

## Doc / tool links

- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Ingress TLS](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)
- [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes) (do not paste proprietary text)
- [kubeadm certs / files](https://kubernetes.io/docs/setup/best-practices/certificates/)
- More links: [docs/sources.md](../../docs/sources.md)

## Gaps

<!-- after practice -->
