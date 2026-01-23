# Terraform: Proxmox network module

This Terraform module manages NICs and Linux bridges across all Proxmox nodes in a cluster.

## Import state

```shell
terraform init
terraform import proxmox_virtual_environment_network_linux_bridge.pve-r740xd_vmbr0 pve-r740xd:vmbr0
terraform import proxmox_virtual_environment_network_linux_bridge.pve-r740xd_vmbr1 pve-r740xd:vmbr1
```
