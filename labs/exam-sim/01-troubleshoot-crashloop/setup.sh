#!/usr/bin/env bash
# Initial broken state: Pod CrashLoopBackOff (bad command).
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-crash
echo "Setting up broken state in namespace ${NS}…"
recreate_ns "${NS}"

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: web
  labels:
    app: web
spec:
  restartPolicy: Always
  containers:
    - name: web
      image: busybox:1.36
      # Broken: exits immediately → CrashLoopBackOff
      command: ["sh", "-c", "echo boom; exit 1"]
EOF

echo
echo "Initial state (expect CrashLoopBackOff after a few seconds):"
kubectl -n "${NS}" get pod web -o wide || true
echo
echo "Setup complete. Fix the Pod, then run: ./labs/exam-sim/01-troubleshoot-crashloop/verify.sh"
