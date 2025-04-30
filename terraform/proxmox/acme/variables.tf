variable "proxmox_host" {
  description = "Proxmox host"
  type        = string
  default     = "192.168.10.11"
}

variable "proxmox_root_password" {
  description = "Proxmox root@pam password"
  type        = string
  sensitive   = true
}

variable "ovh_application_key" {
  description = "OVH application key"
  type        = string
  sensitive   = true
}

variable "ovh_application_secret" {
  description = "OVH application secret"
  type        = string
  sensitive   = true
}

variable "ovh_consumer_key" {
  description = "OVH consumer key"
  type        = string
  sensitive   = true
}
