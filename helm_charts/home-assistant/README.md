# Home-Assistant Using Helm3
breakout of k3s Helm Controller in favor of local helm3

```
helm install home-assistant stable/home-assistant -f values.yaml -n igloo --dry-run
```

```
helm upgrade home-assistant stable/home-assistant -f values.yaml -n igloo --dry-run
```

## Port Forward commands
**Configurator Container**
`kubectl port-forward {home-assistant-xxxxx-xxxx} 3218`

**Dashboard**
`kubectl port-forward {home-assistant-xxxxx-xxxx} 8123`


# Links
- helm repo chart: https://github.com/helm/charts/tree/master/stable/home-assistant
- homeassistant releases: https://github.com/home-assistant/core/releases

# Summary
This is the initial haas setup. It is working locally in the cluster.
- need to setup/sync config
- need to setup external IP
