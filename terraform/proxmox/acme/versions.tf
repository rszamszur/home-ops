terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.77.0"
    }
  }
  required_version = ">= 1.5"
}