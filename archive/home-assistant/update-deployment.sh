#!/bin/bash
set -e

echo "[ INFO ] Applying deployment.yaml to Kubernetes"
kubectl apply -f deployment.yaml
