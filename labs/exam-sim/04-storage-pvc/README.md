# Sim 04 — PVC pending / Pod not mounting (CKA Storage)

| | |
|--|--|
| **Timebox** | 20 minutes |
| **Domains** | [Storage](../../cka/04-storage/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) with default `local-path` StorageClass |
| **Namespace** | `sim-store` |

## Scenario

Pod `db` should mount PVC `db-data` (1Gi, ReadWriteOnce) at `/data` using the cluster default StorageClass. Starting state: PVC never binds (wrong StorageClass name), Pod stays Pending.

## Constraints (exam-like)

- Work only in `sim-store`.
- Keep PVC name `db-data` and Pod name `db`.
- Volume must be mounted at `/data`.

## Starting state

```bash
./labs/exam-sim/04-storage-pvc/setup.sh
```

## Success criteria

```bash
./labs/exam-sim/04-storage-pvc/verify.sh
```

Expect: PVC `db-data` Bound; Pod `db` Ready; `/data` exists inside the container.

## After the timer

Compare with [solutions/](solutions/). Capture gaps in `cka/04-storage/notes.md`.
