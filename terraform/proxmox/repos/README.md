# Terraform: Proxmox APT repositories module

This Terraform module manages Proxmox host APT repositories across all Proxmox nodes in a cluster.

## Import state

```shell
terraform init

terraform import proxmox_virtual_environment_apt_standard_repository.no-subscription[\"pve-t630\"] pve-t630,no-subscription
terraform import proxmox_virtual_environment_apt_standard_repository.enterprise[\"pve-t630\"] pve-t630,enterprise
terraform import proxmox_virtual_environment_apt_standard_repository.ceph-reef-no-subscription[\"pve-t630\"] pve-t630,ceph-reef-no-subscription
terraform import proxmox_virtual_environment_apt_repository.no-subscription[\"pve-t630\"] pve-t630,/etc/apt/sources.list,3
terraform import proxmox_virtual_environment_apt_repository.enterprise[\"pve-t630\"] pve-t630,/etc/apt/sources.list.d/pve-enterprise.list,0
terraform import proxmox_virtual_environment_apt_repository.ceph-reef-no-subscription[\"pve-t630\"] pve-t630,/etc/apt/sources.list.d/ceph.list,0

terraform import proxmox_virtual_environment_apt_standard_repository.no-subscription[\"pve-r740xd\"] pve-r740xd,no-subscription
terraform import proxmox_virtual_environment_apt_standard_repository.enterprise[\"pve-r740xd\"] pve-r740xd,enterprise
terraform import proxmox_virtual_environment_apt_standard_repository.ceph-reef-no-subscription[\"pve-r740xd\"] pve-r740xd,ceph-reef-no-subscription
terraform import proxmox_virtual_environment_apt_repository.no-subscription[\"pve-r740xd\"] pve-r740xd,/etc/apt/sources.list,3
terraform import proxmox_virtual_environment_apt_repository.enterprise[\"pve-r740xd\"] pve-r740xd,/etc/apt/sources.list.d/pve-enterprise.list,0
terraform import proxmox_virtual_environment_apt_repository.ceph-reef-no-subscription[\"pve-r740xd\"] pve-r740xd,/etc/apt/sources.list.d/ceph.list,0
```
