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
  default     = "pve-t630"
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
  default     = "https://ghetto-artifactory.s3.eu-central-1.amazonaws.com/nixos-minimal-25.05.20251016.98ff3f9-x86_64-linux.iso"
}

variable "nixos_iso_checksum" {
  description = "NixOS installation iso checksum"
  type        = string
  default     = "sha256:95d903bf6d93303fb7bfcfa97f87f3dcc9d2f03ad7bb28efd49c46b3e02abfec"
}