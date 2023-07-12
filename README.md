# igloo

_Work in Progress_

<img src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67" align="left" width="144px" height="144px"/>

### k8s based home network 🐧
<br/>
<br/>
<br/>

[![k3s](https://img.shields.io/badge/k3s-v1.27.3-blue?style=flat-square&?logo=kubernetes)](https://k3s.io/)
<br/>


## Overview
- [Cluster Setup](#-cluster-setup)
- [Hardware](#-hardware)
- [Software](#software)
- [Cluster Notes](#cluster-notes)
- [Debugging](#-debugging)
- [Thanks](#-thanks)


## 💻&nbsp; Cluster Setup

#### Install
Follow the detailed guide over at https://github.com/onedr0p/flux-cluster-template


#### Repository structure

```sh
📁 .github         # GH Actions configs, repo reference objects, other GitHub configs
📁 ansible         # Playbooks, inventory, and other automation scripts
📁 kubernetes      # Kubernetes cluster defined as code
├─📁 bootstrap     # Flux installation (not tracked by Flux)
├─📁 flux          # Main Flux configuration of repository
└─📁 apps          # Apps deployed into the cluster grouped by namespace
```


## ⚙&nbsp; Hardware

| Device                          | Count | OS Disk Size    | Data Disk Size       | Ram  | Purpose                       | Alias         | OS                   |
|---------------------------------|-------|-----------------|----------------------|------|-------------------------------|---------------|----------------------|
| raspberry pi 3B+                | 1     | 64GB Flash      | N/A                  | 1GB  | Kubernetes k3s Master         | rpi-node-01   | rasbian lite         |
| raspberry pi 3B+                | 1     | 64GB Flash      | N/A                  | 1GB  | Kubernetes k3s Workers        | rpi-node-02   | rasbian lite         |
| MacBook Pro 2012                | 1     | 250GB SSD       | N/A                  | 8GB  | Kubernetes k3s Worker         | mbp-node-03   | MacOS Big Sur        |
| raspberry pi 3B+ compute module | 2     | 32GB eMMC Flash | N/A                  | 1GB  | Kubernetes k3s Workers        | tpi-node-04/5 | Raspberry Pi OS Lite |
| Helios64 NAS                    | 1     | N/A             | 8x4TB RAID6          | 4GB  | Media and shared file storage | glacier       | Debian GNU/Linux     |
| MacBook Air 2013                | 1     | 250GB SSD       | N/A                  | 8GB  | Kubernetes k3s Master         | mba-node-01   | Debian 12 |


## Software

### 🔧&nbsp; Tools
_Below are some of the tools I'm experimenting with, while working with my cluster_

| Tool                                                   | Purpose                                                                                                   |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| [direnv](https://github.com/direnv/direnv)             | Set `KUBECONFIG` environment variable based on present working directory                                  |
| [sops](https://github.com/mozilla/sops)                | Encrypt secrets                                                                                           |
| [git-crypt](https://github.com/AGWA/git-crypt)         | Encrypt certain files in a repository that can only be decrypted with a key on local computers            |
| [go-task](https://github.com/go-task/task)             | Replacement for make and makefiles                                                                        |
| [pre-commit](https://github.com/pre-commit/pre-commit) | Ensure the YAML and shell script in my repo are consistent                                                |
| [Debian 12](https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/) (for raspi/arm64 use the [tested images](https://raspi.debian.net/tested-images/)) | Operating System to install on nodes                                                |


### 🛎&nbsp; Services
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


## Cluster Notes

### 📄 Configuration
The `template/vars/config.yaml` file contains necessary configuration that is needed by Ansible and Flux. The `template/vars/addons.yaml` file allows you to customize which additional apps you want deployed in your cluster. These files are added to the `.gitignore` file and will not be tracked by Git.


### 🌱 Environment
[direnv](https://direnv.net/) will make it so anytime you `cd` to your repo's directory it export the required environment variables (e.g. `KUBECONFIG`). To set this up make sure you [hook it into your shell](https://direnv.net/docs/hook.html) and after that is done, run `direnv allow` while in your repos directory.


### 📜 Certificates
By default this template will deploy a wildcard certificate with the Let's Encrypt staging servers. This is to prevent you from getting rate-limited on configuration that might not be valid on bootstrap using the production server. Once you have confirmed the certificate is created and valid, make sure to switch to the Let's Encrypt production servers as outlined below. Do not enable the production certificate until you are sure you will keep the cluster up for more than a few hours.
- To view the certificate request run `kubectl -n networking get certificaterequests`
- To verify the certificate is created run `kubectl -n networking get certificates`


### 🌐&nbsp; Networking
The `external-dns` application created in the `networking` namespace will handle creating public DNS records. By default, `echo-server` and the `flux-webhook` are the only public sub-domains exposed. In order to make additional applications public you must set an ingress annotation (`external-dns.alpha.kubernetes.io/target`) like done in the `HelmRelease` for `echo-server`.

For split DNS to work it is required to have `${SECRET_DOMAIN}` point to the `${K8S_GATEWAY_ADDR}` load balancer IP address on your home DNS server. This will ensure DNS requests for `${SECRET_DOMAIN}` will only get routed to your `k8s_gateway` service thus providing **internal** DNS resolution to your cluster applications/ingresses from any device that uses your home DNS server.

[WIP]
TBD: currently experimenting here
1. network consists of [cert-manager](https://github.com/jetstack/cert-manager), [traefik](https://github.com/traefik/traefik), and [tailscale](https://github.com/tailscale/tailscale). Aiming to have all traffic routed through Tailscale VPN over https.
2. network consists of [coredns](https://github.com/coredns/coredns), [etcd](https://github.com/etcd-io/etcd), and [external-dns](https://github.com/kubernetes-sigs/external-dns). **External-DNS** populates **CoreDNS** with all my ingress records and stores it in **etcd**. When browsing any of the services while on my home network, the traffic is being routed internally. When a DNS request is made from my domain or subdomains, it will use **coredns** as the DNS server, otherwise it'll whatever upstream DNS provided.


## 🐛 Debugging
Below is a general guide on trying to debug an issue with an resource or application. For example, if a workload/resource is not showing up or a pod has started but in a `CrashLoopBackOff` or `Pending` state.

1. Start by checking all Flux Kustomizations & Git Repository & OCI Repository and verify they are healthy.
    - `flux get sources oci -A`
    - `flux get sources git -A`
    - `flux get ks -A`
2. Then check all the Flux Helm Releases and verify they are healthy.
    - `flux get hr -A`
3. Then check the if the pod is present.
    - `kubectl -n <namespace> get pods`
4. Then check the logs of the pod if its there.
    - `kubectl -n <namespace> logs <pod-name> -f`

Note: If a resource exists, running `kubectl -n <namespace> describe <resource> <name>` might give you insight into what the problem(s) could be.

Resolving problems could take some tweaking of your YAML manifests in order to get things working, other times it could be a external factor like permissions on NFS.


## 🤝 Thanks
Huge shout out to [@onedr0p](https://github.com/onedr0p) and the k8s@Home community!
