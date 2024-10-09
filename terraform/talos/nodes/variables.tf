variable "proxmox_host" {
  description = "Proxmox host"
  type        = string
  default     = "192.168.10.10"
}

variable "proxmox_token_id" {
  description = "Proxmox token id"
  type        = string
}

variable "proxmox_token_secret" {
  description = "Proxmox token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_vm_template" {
  description = "Proxmox source vm template"
  type        = string
  default     = "talos-node"
}

variable "proxmox_nodename" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "proxmox_vm_template_id" {
  description = "Proxmox source image vm id"
  type        = number
  default     = 200
}

variable "proxmox_cloudinit_storage" {
  description = "Proxmox storage name for CloudInit"
  type        = string
  default     = "local-zfs"
}

variable "proxmox_disk_storage" {
  description = "Proxmox storage name for main disk"
  type        = string
  default     = "nvme-samsung"
}

variable "network_shift" {
  description = "Network number shift"
  type        = number
  default     = 5
}

variable "vpc_main_cidr" {
  description = "Local proxmox subnet"
  type        = string
  default     = "192.168.20.0/24"
}

variable "instances" {
  description = "Map of VMs launched on proxmox hosts"
  type        = map(any)
  default = {
    "pve" = {
      "controlplane" : {
        id      = 600
        cpu     = 4,
        sockets = 2,
        mem     = 16384,
        numa    = true,
        count   = 1,
      },
      "worker" : {
        id      = 1000
        cpu     = 4,
        sockets = 2,
        mem     = 16384,
        numa    = true,
        count   = 4,
      },
      "ingress" : {
        id      = 2000
        cpu     = 2,
        sockets = 2,
        mem     = 8192,
        numa    = true,
        count   = 1,
      }
    }
  }
}