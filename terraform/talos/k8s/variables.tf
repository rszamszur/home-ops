variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "talos-proxmox"
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://192.168.0.127:6443"
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
      "192.168.0.127" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-controlplane-1"
      },
    }
    workers = {
      "192.168.0.227" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-worker-1"
      },
      "192.168.0.173" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-worker-2"
      },
      "192.168.0.144" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-worker-3"
      },
      "192.168.0.132" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-worker-4"
      },
      "192.168.0.177" = {
        install_disk = "/dev/sda"
        hostname     = "pve-talos-ingress-1"
        labels       = "project.io/node-pool: ingress"
      }
    }
  }
}