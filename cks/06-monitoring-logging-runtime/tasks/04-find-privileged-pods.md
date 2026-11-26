# Task 04 — Hunt privileged / hostNetwork Pods

## Objective

Practice investigation commands you will need under time pressure.

## Requirements

1. In any namespace (or create `cks-runtime`), deploy one **deliberately bad** Pod `risky` with `privileged: true` **or** `hostNetwork: true` (tear down after).
2. Use `kubectl get pods -A -o json` + `jq` **or** `kubectl get pods -o jsonpath=…` to list privileged and hostNetwork Pods cluster-wide.
3. Delete `risky` when done.
4. Note one remediation: delete Pod, fix controller template, or enforce PSA/Gatekeeper.

## Verify

Your hunt command prints `risky`; after delete it is gone.
