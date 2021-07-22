# igloo

_Work in Progress_

<img src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67" align="left" width="144px" height="144px"/>

### k8s based home network 🐧

<br/>
<br/>
<br/>

[![k3s](https://img.shields.io/badge/k3s-v1.21.2-blue?style=flat-square&?logo=kubernetes)](https://k3s.io/)

<br/>

## 💻&nbsp; Cluster Setup

#### Install
- Install / Update (with write permissions)
  - `curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -`
- Make sure systemd starts up after install/update (takes a few minutes)
  - `sudo systemctl status k3s`

#### Snippets
Useful snippets when using k3s
- `sudo cat /var/lib/rancher/k3s/server/cred/node-passwd`
- `sudo cat /var/lib/rancher/k3s/agent/node-password.txt`
- `sudo cat /var/lib/rancher/k3s/server/node-token`
- `journalctl -f`

#### Project structure
- `.github` - GitHub Actions configs, repo reference objects, other GitHub configs
- `cluster` - Charts + manifests deployed on cluster.

---

## ⚙&nbsp; Hardware
_Note: in the process of evaluating which OS to go with on all devices._
Currently evaluating RaspiOS, HypriotOS, Ubuntu

| Device                          | Count | OS Disk Size    | Data Disk Size       | Ram  | Purpose                       | Alias         | OS                   |
|---------------------------------|-------|-----------------|----------------------|------|-------------------------------|---------------|----------------------|
| raspberry pi 3B+ compute module | 2     | 32GB eMMC Flash | N/A                  | 1GB  | Kubernetes Master + workers   | tpi-node-01/2 | Raspberry Pi OS Lite |
| raspberry pi 3B+                | 2     | 64GB Flash      | N/A                  | 1GB  | Kubernetes Workers            | rpi-node-03/4 | rasbian lite         |
| MacBook Pro 2012                | 1     | 250GB SSD       | N/A                  | 8GB  | Kubernetes Worker             | hackbook-pro  | Ubuntu 20.4.2        |
| MacBook Air 2012                | 1     | 150GB SSD       | N/A                  | 4GB  | Kubernetes Worker             | hackbook-air  | Ubuntu 20.4.2        |
| Helios64 NAS                    | 1     | 64GB Flash      | 8x4TB RAID6          | 4GB  | Media and shared file storage | glacier       | Debian GNU/Linux     |

---

## 🌐&nbsp; Networking
TBD: currently experimenting here
1. network consists of [cert-manager](https://github.com/jetstack/cert-manager), [traefik](https://github.com/traefik/traefik), and [tailscale](https://github.com/tailscale/tailscale). Aiming to have all traffic routed through Tailscale VPN over https.
2. network consists of [coredns](https://github.com/coredns/coredns), [etcd](https://github.com/etcd-io/etcd), and [external-dns](https://github.com/kubernetes-sigs/external-dns). **External-DNS** populates **CoreDNS** with all my ingress records and stores it in **etcd**. When browsing any of the services while on my home network, the traffic is being routed internally. When a DNS request is made from my domain or subdomains, it will use **coredns** as the DNS server, otherwise it'll whatever upstream DNS provided.

---

## 🔧&nbsp; Tools
_Below are some of the tools I'm experimenting with, while working with my cluster_

| Tool                                                   | Purpose                                                                                                   |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| [direnv](https://github.com/direnv/direnv)             | Set `KUBECONFIG` environment variable based on present working directory                                  |
| [sops](https://github.com/mozilla/sops)                | Encrypt secrets                                                                                           |
| [go-task](https://github.com/go-task/task)             | Replacement for make and makefiles                                                                        |
| [pre-commit](https://github.com/pre-commit/pre-commit) | Ensure the YAML and shell script in my repo are consistent                                                |

---

## 🛎&nbsp; Services
Here's a list of third-party applications I'm using alongside custom applications:

- [home-assistant](https://www.home-assistant.io/) - Open source home automation that puts local control and privacy first.
- [pihole](https://pi-hole.net/) - A black hole for Internet advertisements.
- [traefik](https://github.com/traefik/traefik) - Cloud Native Application Proxy.
- [tailscale](https://github.com/tailscale/tailscale)
- [prometheus](https://github.com/prometheus/prometheus) - Monitoring system and time series database.
- [grafana](https://github.com/grafana/grafana) - Open observability platform.
- [postgres](https://www.postgresql.org/) - The world's most advanced open source database.
- [cert-manager](https://github.com/jetstack/cert-manager) - x509 certificate management for Kubernetes.
- [rabbitmq](https://github.com/rabbitmq/rabbitmq-server)

**Services I'm evaluating**
- [concourse](https://github.com/concourse/concourse) - container-based continuous thing-doer
- [actionsflow](https://github.com/actionsflow/actionsflow) - self hosted zapier alternative
- [longhorn](https://longhorn.io/) - Cloud native distributed block storage for Kubernetes.
- [minio](https://github.com/minio/minio) - High Performance, Kubernetes Native Object Storage.
- [firefly](https://github.com/firefly-iii/firefly-iii/) - A free and open source personal finances manager.
- [jellyfin](https://github.com/jellyfin/jellyfin)
- [monitoror](https://github.com/monitoror/monitoror)
- [heimdall](https://github.com/linuxserver/Heimdall)
- [k8s-fah](https://github.com/richstokes/k8s-fah)
- [Cloudflare](https://www.cloudflare.com/) - DNS, used to access applications under the `*.igloo.sh` domain.
