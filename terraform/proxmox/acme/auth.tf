provider "proxmox" {
  endpoint  = "https://${var.proxmox_host}:8006/"
  insecure  = true
  username  = "root@pam"
  password  = var.proxmox_root_password
}
