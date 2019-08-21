#!/bin/bash
set -e

echo "[ INFO ] Generating configmap.yaml from files in /config"
kubectl create configmap hass-config --namespace=igloo --from-file=config/ -o yaml --dry-run > configmap.yaml

echo "[ INFO ] Applying configmap.yaml to Kubernetes"
kubectl apply -f configmap.yaml
