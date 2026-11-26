# Storage (10%)

Competencies: StorageClasses & dynamic provisioning; volume types, access modes, reclaim policies; PV / PVC management.

## Skill checklist

- [ ] PersistentVolume / PersistentVolumeClaim binding
- [ ] Access modes: RWO, ROX, RWX
- [ ] Reclaim policies: Retain, Delete, Recycle (legacy)
- [ ] StorageClass parameters & default class annotation
- [ ] Mount PVC into Pod / Deployment
- [ ] emptyDir, hostPath awareness (when exams still use them)
- [ ] ConfigMap/Secret volumes vs PVCs (don't confuse)

## High-value commands

```bash
kubectl get sc,pv,pvc -A
kubectl describe pvc <name>
kubectl get events --field-selector involvedObject.name=<pvc>
```

## Doc links

- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)
- [Configure a Pod to Use a PersistentVolume for Storage](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)
- [Dynamic Volume Provisioning](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/)

## Lab notes

- kind-bootstrap installs **local-path** as default StorageClass — required for dynamic PVC drills.
- RWO + multiple replicas on different nodes → Multi-Attach errors; use 1 replica for RWO tests.

## Gaps

<!-- after practice -->
