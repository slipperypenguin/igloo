Attempt to manage traefik outside of k3s

This is the same config as k3s default, but with the dashboard enabled and the latest stable 1.7 version

helm repo chart: https://github.com/helm/charts/tree/master/stable/traefik
reference: https://github.com/rancher/k3s/pull/1021

Start your k3s server **without traefik** server option `--no-deploy traefik` and deploy the helm manifest
docs: https://rancher.com/docs/k3s/latest/en/installation/install-options/

traefik dashboard docs
  - https://docs.traefik.io/v1.7/configuration/api/#dashboard-web-ui

traefik helm links:
  - https://hub.helm.sh/charts/stable/traefik
  -

1. get this working with the v1 version of traefik
2. upgrade to traefik v2
