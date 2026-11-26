# Solution 04 — Gatekeeper allowed repos (illustrative)

Prefer the maintained [k8sallowedrepos](https://github.com/open-policy-agent/gatekeeper-library) template in real clusters. Minimal sketch:

```yaml
apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8sallowedrepos
spec:
  crd:
    spec:
      names:
        kind: K8sAllowedRepos
      validation:
        openAPIV3Schema:
          type: object
          properties:
            repos:
              type: array
              items:
                type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8sallowedrepos
        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          satisfied := [r | r := input.parameters.repos[_]; startswith(container.image, r)]
          count(satisfied) == 0
          msg := sprintf("image '%v' not from allowed repos", [container.image])
        }
---
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sAllowedRepos
metadata:
  name: repo-must-be-allowed
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
  parameters:
    repos:
      - "registry.k8s.io/"
      - "docker.io/library/"
```

Install Gatekeeper per project docs before apply. Kyverno alternative: task 02.
