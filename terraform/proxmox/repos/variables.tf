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

variable "proxmox_nodes" {
  description = "Proxmox nodes names"
  type        = set(string)
  default     = ["pve-r740xd", "pve-t630"]
}
