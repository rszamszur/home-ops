terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.78.1"
    }
  }
  required_version = ">= 1.5"
}