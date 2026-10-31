# Terraform: Proxmox network module

This Terraform module manages NICs and Linux bridges across all Proxmox nodes in a cluster.

## Import state

```shell
terraform init
terraform import proxmox_virtual_environment_network_linux_bridge.pve-odin_vmbr0 pve-odin:vmbr0
terraform import proxmox_virtual_environment_network_linux_bridge.pve-odin_vmbr1 pve-odin:vmbr1
```
