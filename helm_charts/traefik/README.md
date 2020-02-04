# traefik

## About
Attempt to manage traefik outside of k3s

This chart bootstraps Traefik as a Kubernetes ingress controller with optional support for SSL and Let's Encrypt.

NOTE: Operators will typically wish to install this component into the `kube-system` namespace where that namespace's default service account will ensure adequate privileges to watch Ingress resources cluster-wide.

This is the same config as k3s default, but with the dashboard enabled and the latest stable 1.7 version

## Resources
helm repo chart: https://github.com/helm/charts/tree/master/stable/traefik
reference: https://github.com/rancher/k3s/pull/1021

Start your k3s server **without traefik** server option `--no-deploy traefik` and deploy the helm manifest
docs: https://rancher.com/docs/k3s/latest/en/installation/install-options/

traefik dashboard docs
  - https://docs.traefik.io/v1.7/configuration/api/#dashboard-web-ui

traefik helm links:
  - v1: https://hub.helm.sh/charts/stable/traefik
  - v2: https://github.com/containous/traefik-helm-chart

1. get this working with the v1 version of traefik
2. upgrade to traefik v2
