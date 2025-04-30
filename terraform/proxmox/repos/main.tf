resource "proxmox_virtual_environment_apt_standard_repository" "no-subscription" {
  for_each  = var.proxmox_nodes
  handle = "no-subscription"
  node   = each.value
}

resource "proxmox_virtual_environment_apt_standard_repository" "enterprise" {
  for_each  = var.proxmox_nodes
  handle = "enterprise"
  node   = each.value
}

resource "proxmox_virtual_environment_apt_standard_repository" "ceph-reef-no-subscription" {
  for_each  = var.proxmox_nodes
  handle = "ceph-reef-no-subscription"
  node   = each.value
}

resource "proxmox_virtual_environment_apt_repository" "no-subscription" {
  for_each  = var.proxmox_nodes
  enabled   = true
  file_path = proxmox_virtual_environment_apt_standard_repository.no-subscription[each.value].file_path
  index     = proxmox_virtual_environment_apt_standard_repository.no-subscription[each.value].index
  node      = proxmox_virtual_environment_apt_standard_repository.no-subscription[each.value].node
}

resource "proxmox_virtual_environment_apt_repository" "enterprise" {
  for_each  = var.proxmox_nodes
  enabled   = false
  file_path = proxmox_virtual_environment_apt_standard_repository.enterprise[each.value].file_path
  index     = proxmox_virtual_environment_apt_standard_repository.enterprise[each.value].index
  node      = proxmox_virtual_environment_apt_standard_repository.enterprise[each.value].node
}

resource "proxmox_virtual_environment_apt_repository" "ceph-reef-no-subscription" {
  for_each  = var.proxmox_nodes
  enabled   = true
  file_path = proxmox_virtual_environment_apt_standard_repository.ceph-reef-no-subscription[each.value].file_path
  index     = proxmox_virtual_environment_apt_standard_repository.ceph-reef-no-subscription[each.value].index
  node      = proxmox_virtual_environment_apt_standard_repository.ceph-reef-no-subscription[each.value].node
}
