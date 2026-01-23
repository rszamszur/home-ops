variable "proxmox_host" {
  description = "Proxmox host"
  type        = string
  default     = "192.168.10.11"
}

variable "proxmox_token_id" {
  description = "Proxmox token id"
  type        = string
}

variable "proxmox_token_secret" {
  description = "Proxmox token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_nodename" {
  description = "Proxmox node name"
  type        = string
  default     = "pve-r740xd"
}

variable "proxmox_storage" {
  description = "Proxmox storage name"
  type        = string
  default     = "hddexos"
}

variable "proxmox_interface" {
  description = "Proxmox network interface name"
  type        = string
  default     = "vmbr1"
}

variable "network_vlan_tag" {
  description = "Network VLAN tag"
  type        = string
  default     = ""
}

variable "talos_version" {
  description = "Talos release version"
  type        = string
  default     = "v1.10.0"
}

locals {
  # https://factory.talos.dev/?arch=amd64&cmdline-set=true&extensions=-&extensions=siderolabs%2Fiscsi-tools&platform=nocloud&target=cloud&version=1.7.7
  image = "https://factory.talos.dev/image/c9078f9419961640c712a8bf2bb9174933dfcf1da383fd8ea2b7dc21493f8bac/${var.talos_version}/nocloud-amd64.raw.xz"
}