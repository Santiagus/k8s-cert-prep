# Sim 01 — CrashLoopBackOff (CKA Troubleshooting)

| | |
|--|--|
| **Timebox** | 15 minutes |
| **Domains** | [Troubleshooting](../../cka/05-troubleshooting/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-crash` |

## Scenario

Ops reports Pod `web` in namespace `sim-crash` is stuck restarting. Bring it to a healthy Running state so it serves a simple HTTP response.

## Constraints (exam-like)

- Fix the existing workload; you may edit or replace resources in `sim-crash` only.
- Use `kubectl` and kubernetes.io docs. Do not open `solutions/` until the timer ends.
- Success is the **final cluster state**, not a particular edit style.

## Starting state

```bash
./labs/exam-sim/01-troubleshoot-crashloop/setup.sh
```

## Success criteria

```bash
./labs/exam-sim/01-troubleshoot-crashloop/verify.sh
```

Expect: Pod `web` Ready; container is not CrashLooping; a request against the Pod returns HTTP success (verify script checks readiness and that the process stays up).

## After the timer

Compare with [solutions/](solutions/). Capture gaps in `cka/05-troubleshooting/notes.md`.
