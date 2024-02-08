variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
  sensitive = true
}

variable "proxmox_nodename" {
  type = string
  default = "pve"
}

variable "proxmox_storage" {
  type = string
  default = "local-zfs"
}

variable "talos_version" {
  type = string
  default = "v1.6.4"
}

locals {
  image = "https://github.com/talos-systems/talos/releases/download/${var.talos_version}/metal-amd64.raw.xz"
}