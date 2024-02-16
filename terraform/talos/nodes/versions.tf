terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.46.4"
    }
  }
  required_version = ">= 1.5"
}