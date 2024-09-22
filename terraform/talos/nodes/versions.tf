terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.65.0"
    }
  }
  required_version = ">= 1.5"
}