# Solution 03 — Falco shell rule (illustrative)

```yaml
- rule: Shell in container (lab)
  desc: Detect bash/sh spawned inside a container (lab sketch)
  condition: >
    spawned_process
    and container
    and proc.name in (bash, sh, zsh)
  output: >
    Shell in container (user=%user.name pod=%k8s.pod.name ns=%k8s.ns.name
    cmdline=%proc.cmdline)
  priority: WARNING
  tags: [cka_lab, shell, container]
```

Merge via Falco `customRules` / rules ConfigMap per [Falco docs](https://falco.org/docs/rules/). Trigger: `kubectl exec -it <pod> -- sh`. Prefer official macros (`spawned_process`, `container`) from the version you install — field names evolve.
