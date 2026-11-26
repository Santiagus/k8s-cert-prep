# Exam tips (CKA / CKS)

Logistics change; verify the [Linux Foundation candidate handbook](https://docs.linuxfoundation.org/tc-docs/certification/lf-candidate-handbook) and the current exam page before your sitting.

## Format (typical)

- Performance-based: fix / create / diagnose in a live cluster — not multiple choice.
- Remote proctoring via **PSI Online** (or current LF vendor) — quiet room, ID check, webcam.
- Fixed time window; skip stuck items and return.
- Docs: kubernetes.io (and whatever the handbook allow-lists for that exam version). Bookmark nothing proprietary.

## Timeboxing

1. Read the full question; write down **namespace**, **resource names**, and **success criteria**.
2. Do high-confidence / high-weight items first if order is free; otherwise work top to bottom but **skip** after ~2–3 minutes stuck.
3. Always **verify** (`get`, `describe`, `logs`, `exec` connectivity checks) before marking done.
4. Leave buffer for Troubleshooting-style items — they are 30% of CKA.

## kubectl habits

- Imperative first; dry-run YAML when needed — see [kubectl-cheatsheet.md](kubectl-cheatsheet.md).
- `kubectl explain` instead of memorizing API fields.
- Copy working YAML from docs; do not invent field names.
- Alias / bash history: use what the exam environment provides; do not rely on personal shell rc files unless allowed.

## Common traps

- Wrong namespace (`-n` / `--namespace` / context default).
- Forgetting to scale / wait for rollout (`rollout status`).
- NetworkPolicy with a CNI that does not enforce policies.
- PVC pending because no StorageClass / provisioner.
- Editing static Pod manifests under `/etc/kubernetes/manifests` without watching kubelet recreate them.
- etcd snapshot restore: restore data **and** restart API server / etcd correctly (follow official kubeadm docs).

## Practice cadence

- Domain tasks in this repo → verify against `solutions/`.
- Timed [labs/](../labs/) closer to exam week.
- Optional paid Killer.sh (voucher) as a dress rehearsal — do not paste those scenarios here.
