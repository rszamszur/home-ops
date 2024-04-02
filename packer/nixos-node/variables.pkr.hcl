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
  default     = "local-zfs"
}

variable "nixos_iso" {
  description = "NixOS installation iso url"
  type        = string
  default     = "https://ghetto-artifactory.s3.eu-central-1.amazonaws.com/custom-nixos-minimal-x86_64-linux.iso"
}

variable "nixos_iso_checksum" {
  description = "NixOS installation iso checksum"
  type        = string
  default     = "sha256:be17c37038e58aea913afe4cf6e7bfa02d2b723c621440c36109a3a1c48b6294"
}