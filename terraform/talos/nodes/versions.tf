terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.58.0"
    }
  }
  required_version = ">= 1.5"
}