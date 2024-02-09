variable "proxmox_host" {
  description = "Proxmox host"
  type        = string
  default     = "192.168.0.10"
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
  default     = "pve"
}

variable "proxmox_storage" {
  description = "Proxmox storage name"
  type        = string
  default     = "local-zfs"
}

variable "talos_version" {
  description = "Talos release version"
  type        = string
  default     = "v1.6.4"
}

locals {
  image = "https://github.com/talos-systems/talos/releases/download/${var.talos_version}/metal-amd64.raw.xz"
}