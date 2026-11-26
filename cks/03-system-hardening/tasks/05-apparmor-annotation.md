# Task 05 — AppArmor profile reference

## Objective

Attach an AppArmor profile reference to a container (lab may be annotation-only on kind).

## Requirements

1. Namespace `cks-sys`.
2. Pod `apparmor-pod` with either:
   - annotation `container.apparmor.security.beta.kubernetes.io/<container>: runtime/default`, **or**
   - container `securityContext.appArmorProfile.type: RuntimeDefault` (supported API versions).
3. Pod should be Running if the node supports the profile; if kind rejects/ignores, keep the manifest correct and note node support in Gaps.

## Verify

```bash
kubectl -n cks-sys get pod apparmor-pod -o yaml | grep -i apparmor
```
