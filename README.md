# igloo
🐧 k8s based home network

_Work in Progress_

## Tools
- k3s
- [rasbian lite](https://www.raspberrypi.org/downloads/raspbian/)
- Debian GNU/Linux
- MacOS

### Devices Used
- 2, rpi 3 B+ (nodes)
- 1, MacBook Pro 2012 (master node)

### Services
- prometheus
- traefik
- home-assistant
- concourse
- rabbitmq


## Install
- Install / Update (with write permissions)
  - `curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -`
- Install v1 without traefik (traefik v2 is used separately)
  - `curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=“644” INSTALL_K3S_VERSION=v1.0.0 sh -s - --no-deploy traefik`
- Make sure systemd starts up after install/update (takes a few minutes)
  - `sudo systemctl status k3s`

### Snippets
Useful snippets when using k3s
- `sudo cat /var/lib/rancher/k3s/server/cred/node-passwd`
- `sudo cat /var/lib/rancher/k3s/agent/node-password.txt`
- `sudo cat /var/lib/rancher/k3s/server/node-token`
- `journalctl -f`

### Note on Secrets
- in order to commit secrets to git, they **must** be encrypted (via `./tools/encrypt.sh`)
