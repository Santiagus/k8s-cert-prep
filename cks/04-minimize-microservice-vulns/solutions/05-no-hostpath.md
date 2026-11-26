# Solution 05 — emptyDir scratch

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: scratch
  namespace: cks-psa
spec:
  containers:
    - name: box
      image: busybox:1.36
      command: ["sleep", "3600"]
      volumeMounts:
        - name: data
          mountPath: /data
  volumes:
    - name: data
      emptyDir: {}
```

`hostPath` mounts node filesystem into the Pod — compromise can read/write host paths. Prefer emptyDir/PVC.
