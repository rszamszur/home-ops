# Terraform: Proxmox APT repositories module

This Terraform module manages Proxmox host APT repositories across all Proxmox nodes in a cluster.

## Import state

```shell
terraform init

terraform import proxmox_virtual_environment_apt_standard_repository.no-subscription[\"pve-odin\"] pve-odin,no-subscription
terraform import proxmox_virtual_environment_apt_standard_repository.enterprise[\"pve-odin\"] pve-odin,enterprise
terraform import proxmox_virtual_environment_apt_standard_repository.ceph-reef-no-subscription[\"pve-odin\"] pve-odin,ceph-reef-no-subscription
terraform import proxmox_virtual_environment_apt_repository.no-subscription[\"pve-odin\"] pve-odin,/etc/apt/sources.list,3
terraform import proxmox_virtual_environment_apt_repository.enterprise[\"pve-odin\"] pve-odin,/etc/apt/sources.list.d/pve-enterprise.list,0
terraform import proxmox_virtual_environment_apt_repository.ceph-reef-no-subscription[\"pve-odin\"] pve-odin,/etc/apt/sources.list.d/ceph.list,0
```
