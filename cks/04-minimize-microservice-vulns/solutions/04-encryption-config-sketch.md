# Solution 04 — EncryptionConfiguration sketch

Illustrative only — **fake** key material; never commit real keys:

```yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: CHANGE_ME_TO_32_BYTE_BASE64_VALUE__________
      - identity: {}
```

kube-apiserver: `--encryption-provider-config=/path/encryption-config.yaml`

Rotate: add new key first in list → restart API servers → `kubectl get secrets -A -o json | kubectl replace -f -` style re-encrypt → remove old key. Follow [encrypt-data](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/).
