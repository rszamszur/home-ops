resource "proxmox_virtual_environment_network_linux_bridge" "pve-odin_vmbr0" {
  node_name = "pve-odin"
  name      = "vmbr0"

  address = "192.168.10.10/24"
  gateway = "192.168.10.1"
  vlan_aware = false
  comment = "Bridge for host. Native VLAN: management. Managed by terraform"

  ports = [
    "nic1"
  ]
}

resource "proxmox_virtual_environment_network_linux_bridge" "pve-odin_vmbr1" {
  node_name = "pve-odin"
  name      = "vmbr1"

  vlan_aware = true
  comment = "Bridge for VMs. Native VLAN: servers. Managed by terraform"

  ports = [
    "nic2"
  ]
}

# resource "proxmox_virtual_environment_network_linux_bridge" "pve-odin_vmbr2" {
#   node_name = "pve-odin"
#   name      = "vmbr2"

#   vlan_aware = true
#   comment = "Bridge for puqu. Native VLAN: servers-puqu. Managed by terraform"

#   ports = [
#     "eno2np1"
#   ]
# }
