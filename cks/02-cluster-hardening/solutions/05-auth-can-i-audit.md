# Solution 05 — can-i audit

```bash
kubectl auth can-i --list --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard
kubectl auth can-i create deployments.apps --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard
# expect: no
```

Fast exam habit: after every RoleBinding, run `--list` and one negative `can-i` before moving on.
