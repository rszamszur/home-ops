variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "talos-proxmox"
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://192.168.20.10:6443"
}

variable "node_data" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      install_disk = string
      hostname     = optional(string)
    }))
    workers = map(object({
      install_disk = string
      hostname     = optional(string)
      labels       = optional(string)
    }))
  })
  default = {
    controlplanes = {
      "192.168.20.10" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-controlplane-1"
      },
    }
    workers = {
      "192.168.20.21" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-worker-1"
      },
      "192.168.20.22" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-worker-2"
      },
      "192.168.20.23" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-worker-3"
      },
      "192.168.20.24" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-worker-4"
      },
      "192.168.20.20" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-ingress-1"
        labels       = "project.io/node-pool: ingress"
      }
    }
  }
}