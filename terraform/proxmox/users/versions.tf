terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.83.2"
    }
  }
  required_version = ">= 1.5"
}