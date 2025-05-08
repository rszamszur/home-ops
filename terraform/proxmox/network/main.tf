resource "proxmox_virtual_environment_network_linux_bridge" "pve-r740xd_vmbr0" {
  node_name = "pve-r740xd"
  name      = "vmbr0"

  address = "192.168.10.11/24"
  gateway = "192.168.10.1"
  vlan_aware = false
  comment = "Bridge for host. Native VLAN: management. Managed by terraform"

  ports = [
    "eno3"
  ]
}

resource "proxmox_virtual_environment_network_linux_bridge" "pve-r740xd_vmbr1" {
  node_name = "pve-r740xd"
  name      = "vmbr1"

  vlan_aware = true
  comment = "Bridge for VMs. Native VLAN: servers. Managed by terraform"

  ports = [
    "eno1np0"
  ]
}

resource "proxmox_virtual_environment_network_linux_bridge" "pve-r740xd_vmbr2" {
  node_name = "pve-r740xd"
  name      = "vmbr2"

  vlan_aware = true
  comment = "Bridge for puqu. Native VLAN: servers-puqu. Managed by terraform"

  ports = [
    "eno2np1"
  ]
}

resource "proxmox_virtual_environment_network_linux_bridge" "pve-t630_vmbr0" {
  node_name = "pve-t630"
  name      = "vmbr0"

  address = "192.168.10.10/24"
  gateway = "192.168.10.1"
  vlan_aware = true
  comment = "Bridge for host. Native VLAN: management. Managed by terraform"

  ports = [
    "bond0"
  ]
}

resource "proxmox_virtual_environment_network_linux_bridge" "pve-t630_vmbr1" {
  node_name = "pve-t630"
  name      = "vmbr1"

  vlan_aware = true
  comment = "Bridge for VMs. Native VLAN: servers. Managed by terraform"

  ports = [
    "enp129s0f0"
  ]
}

resource "proxmox_virtual_environment_network_linux_bridge" "pve-t630_vmbr2" {
  node_name = "pve-t630"
  name      = "vmbr2"

  vlan_aware = true
  comment = "Bridge for puqu. Native VLAN: servers-puqu. Managed by terraform"

  ports = [
    "enp129s0f1"
  ]
}
