# Procedure: Update Talos Linux

## Overview

This procedure outlines the steps to update Talos Linux. Updating Talos Linux ensures that your cluster nodes are running the latest version, which includes security patches, bug fixes, and new features. This process involves using the `talosctl` command-line tool to upgrade the Talos OS on each node in the cluster, typically starting with worker nodes and finishing with control plane nodes.

## Prerequisites

### Required Tools

* `talosctl`

### Get Talos nodes external IP's

```shell
$ kubectl get nodes -o wide
NAME                       STATUS   ROLES           AGE    VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE         KERNEL-VERSION   CONTAINER-RUNTIME
pve-talos-controlplane-1   Ready    control-plane   238d   v1.29.0   192.168.20.10   <none>        Talos (v1.7.7)   6.6.52-talos     containerd://1.7.22
pve-talos-ingress-1        Ready    <none>          238d   v1.29.0   192.168.20.20   <none>        Talos (v1.7.7)   6.6.52-talos     containerd://1.7.22
pve-talos-worker-1         Ready    <none>          238d   v1.29.0   192.168.20.21   <none>        Talos (v1.7.7)   6.6.52-talos     containerd://1.7.22
pve-talos-worker-2         Ready    <none>          238d   v1.29.0   192.168.20.22   <none>        Talos (v1.7.7)   6.6.52-talos     containerd://1.7.22
pve-talos-worker-3         Ready    <none>          238d   v1.29.0   192.168.20.23   <none>        Talos (v1.7.7)   6.6.52-talos     containerd://1.7.22
pve-talos-worker-4         Ready    <none>          238d   v1.29.0   192.168.20.24   <none>        Talos (v1.7.7)   6.6.52-talos     containerd://1.7.22
```

## Procedure Steps

For each node in cluster do:

### 1. Find Schematic ID from Talos Installation

```shell
$ talosctl --nodes <NODE_IP> get extensions
NODE            NAMESPACE   TYPE              ID   VERSION   NAME          VERSION
192.168.20.24   runtime     ExtensionStatus   0    1         iscsi-tools   v0.1.4
192.168.20.24   runtime     ExtensionStatus   1    1         schematic     c9078f9419961640c712a8bf2bb9174933dfcf1da383fd8ea2b7dc21493f8bac
```

### 2. Construct Talos Linux image url

```shell
export TALOS_LINUX_VERSION="v1.7.7"
export TALOS_LINUX_SCHEMATIC_ID="c9078f9419961640c712a8bf2bb9174933dfcf1da383fd8ea2b7dc21493f8bac"
export TALOS_IMAGE_URL="factory.talos.dev/installer/$TALOS_LINUX_SCHEMATIC_ID:$TALOS_LINUX_VERSION"
```

### 3. Execute upgrade

```shell
talosctl upgrade --nodes <NODE_IP> --image $TALOS_IMAGE_URL
```

> [!NOTE]  
> When updating the control plane in a single-control-plane Kubernetes cluste, a `--preserve` flag is required.

### 4. Verify

```shell
talosctl version --nodes <NODE_IP>
```

Example out: 
```shell
...
Server:
	NODE:        192.168.20.24
	Tag:         v1.7.7 <-- Target Talos Linux version
	SHA:         68794084
	Built:       
	Go version:  go1.22.7
	OS/Arch:     linux/amd64
	Enabled:     RBAC
```

## Related Procedures

N/A

## Troubleshooting

N/A

## Resources

* https://www.talos.dev/v1.8/talos-guides/upgrading-talos/
* https://www.talos.dev/v1.8/learn-more/image-factory/
* https://www.talos.dev/v1.10/advanced/disaster-recovery/