# Bootstrap Proxmox

## Prerequisites

1. Ensure Boot Mode is set to UEFI - [Dell T630 manual](https://www.dell.com/support/manuals/pl-pl/poweredge-t630/t630_om/boot-settings-details?guid=guid-2f825dc7-a22a-482f-bbec-c2c19fe78781&lang=en-us)
2. Flash USB
```shell
wget -O proxmox.iso https://www.proxmox.com/en/downloads/proxmox-virtual-environment/iso
sudo dd in=./proxmox.iso of=/dev/XYZ bs=1M conv=fdatasync
```

## Installation

1. Set disk setup to ZFS (RAID 1)
2. Set static IP to 192.168.0.10
3. Set FQDN to pve.rsd.sh

## Post installation setup

### 1. Update Proxmox sources to non subscription based

```shell
# 1st
# https://pve.proxmox.com/wiki/Package_Repositories#sysadmin_no_subscription_repo
echo "# not for production use" >> /etc/apt/sources.list
echo "deb http://download.proxmox.com/debian bookworm pve-no-subscription" >> /etc/apt/sources.list
# 2nd
# comment pve-enterprise line in /etc/apt/sources.list.d/pve-enterprise.list

# 3rd
# https://pve.proxmox.com/wiki/Package_Repositories#_ceph_quincy_no_subscription_repository
echo "deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription" > /etc/apt/sources.list.d/ceph.list

# 4th
# run updates
apt update
apt dist-upgrade
```

### 2. [Enable PCI Passthrough (IOMMU)](https://pve.proxmox.com/wiki/PCI_Passthrough)

1. Enable IOMMU on the kernel command line
```shell
# https://pve.proxmox.com/pve-docs/pve-admin-guide.html#qm_pci_passthrough
# For Grub boot
sed -i 's\GRUB_CMDLINE_LINUX_DEFAULT="quiet"\GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"\g' /etc/default/grub
update-grub
# For systemd boot
sed -i 's/$/ intel_iommu=on iommu=pt/' /etc/kernel/cmdline
proxmox-boot-tool refresh
```

2. Update kernel modules
```shell
# Update kernel modules
echo "vfio" >> /etc/modules
echo "vfio_iommu_type1" >> /etc/modules
echo "vfio_pci" >> /etc/modules
# After changing anything modules related, you need to refresh your initramfs
update-initramfs -u -k all
```

3. To check if the modules are being loaded, the output of should include the four modules from above
```shell
lsmod | grep vfio
# Example output
root@pve:~# lsmod | grep vfio
vfio_pci               16384  0
vfio_pci_core          86016  1 vfio_pci
irqbypass              12288  2 vfio_pci_core,kvm
vfio_iommu_type1       49152  0
vfio                   57344  3 vfio_pci_core,vfio_iommu_type1,vfio_pci
iommufd                77824  1 vfio
```

4. Reboot Proxmox
```shell
reboot
```

5. Verify
```shell
dmesg | grep -e DMAR -e IOMMU
# There should be a line that looks like "DMAR: IOMMU enabled"
# Example output:
root@pve:~# dmesg | grep -e DMAR -e IOMMU
[    0.009080] ACPI: DMAR 0x000000007BAFE000 000108 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.009110] ACPI: Reserving DMAR table memory at [mem 0x7bafe000-0x7bafe107]
[    0.753603] DMAR: IOMMU enabled
[    1.639299] DMAR: Host address width 46
[    1.639302] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    1.639309] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.639314] DMAR: DRHD base: 0x000000c7ffc000 flags: 0x1
[    1.639319] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.639323] DMAR: RMRR base: 0x0000006833d000 end: 0x00000070344fff
[    1.639327] DMAR: ATSR flags: 0x0
[    1.639330] DMAR: ATSR flags: 0x0
[    1.639333] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffc000 IOMMU 0
[    1.639337] DMAR-IR: IOAPIC id 8 under DRHD base  0xc7ffc000 IOMMU 1
[    1.639340] DMAR-IR: IOAPIC id 9 under DRHD base  0xc7ffc000 IOMMU 1
[    1.639343] DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
[    1.639346] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    1.639347] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    1.640205] DMAR-IR: Enabled IRQ remapping in xapic mode
[    2.227561] DMAR: [Firmware Bug]: RMRR entry for device 03:00.0 is broken - applying workaround
[    2.227666] DMAR: No SATC found
[    2.227672] DMAR: dmar0: Using Queued invalidation
[    2.227683] DMAR: dmar1: Using Queued invalidation
[    2.251046] DMAR: Intel(R) Virtualization Technology for Directed I/O
```

### 3. Set VLAN Aware

Network > vmbr0 > click edit > check VLAN aware > OK

### 4. Test email alerts

Datacenter > Notifications > test default `mail-to-root` notificaion target
