template for how to utilize helm charts in [k3s](https://rancher.com/docs/k3s/latest/en/configuration/)

### Useful Links
- [issue](https://github.com/rancher/k3s/issues/526) for better k3s helm install docs
- [helm hub](https://hub.helm.sh) for helm charts

- [k3s helm guide](https://medium.com/@marcovillarreal_40011/cheap-and-local-kubernetes-playground-with-k3s-helm-5a0e2a110de9) looks like we can just go through the helm install while ssh'd

---
## Using the helm CRD
**You can deploy a 3rd party helm chart using an example like this:**
```yaml
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: nginx
  namespace: kube-system
spec:
  chart: nginx
  repo: https://charts.bitnami.com/bitnami
  targetNamespace: default
```

**You can install a specific version of a helm chart using an example like this:**
```yaml
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: stable/home-assistant
  namespace: kube-system
spec:
  chart: home-assistant
  version: 0.9.9
  targetNamespace: igloo
  ```
