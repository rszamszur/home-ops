variable "proxmox_host" {
  description = "Proxmox host"
  type        = string
  default     = "192.168.10.10"
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

variable "nixos_iso" {
  description = "NixOS installation iso url"
  type        = string
  default     = "https://ghetto-artifactory.s3.eu-central-1.amazonaws.com/nixos-24.05.20241028.64b80bf-x86_64-linux.iso"
}

variable "nixos_iso_checksum" {
  description = "NixOS installation iso checksum"
  type        = string
  default     = "sha256:3974e10067e93592cd546a90cd3611803c8792c6777fb546f9546dfed9d2099a"
}