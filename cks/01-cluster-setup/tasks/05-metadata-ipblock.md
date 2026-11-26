# Task 05 — Block cloud metadata via ipBlock

## Objective

Write a NetworkPolicy that denies egress to the classic cloud instance metadata address.

## Requirements

1. Namespace `cks-setup`.
2. NetworkPolicy `deny-metadata` selecting Pods `app=web`.
3. policyTypes include Egress.
4. Use an egress rule pattern that **blocks** `169.254.169.254/32` while still allowing other egress you need — common exam pattern: allow `0.0.0.0/0` with `except: [169.254.169.254/32]` (and separately allow DNS if you also default-deny).
5. Note this is conceptual on kind (no IMDS); correctness of the object matters.

## Verify

```bash
kubectl -n cks-setup get netpol deny-metadata -o yaml
# confirm except or explicit deny targeting 169.254.169.254/32
```
