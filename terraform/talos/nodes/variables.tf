variable "proxmox_host" {
  description = "Proxmox host"
  type        = string
  default     = "pve-odin.szamszur.cloud"
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
  default     = "pve-odin"
}

variable "proxmox_vm_template_id" {
  description = "Proxmox source image vm id"
  type        = number
  default     = 200
}

variable "proxmox_cloudinit_storage" {
  description = "Proxmox storage name for CloudInit"
  type        = string
  default     = "ssd-870-evo"
}

variable "proxmox_disk_storage" {
  description = "Proxmox storage name for main disk"
  type        = string
  default     = "nvme-wd-red"
}

variable "network_shift" {
  description = "Network number shift"
  type        = number
  default     = 1
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
    "pve-odin" = {
      "controlplane" : {
        id      = 1000
        cpu     = 8,
        sockets = 1,
        mem     = 12288,
        numa    = false,
        count   = 1,
      },
      "worker" : {
        id      = 1100
        cpu     = 12,
        sockets = 1,
        mem     = 32768,
        numa    = false,
        count   = 3,
      },
      "ingress" : {
        id      = 1200
        cpu     = 12,
        sockets = 1,
        mem     = 32768,
        numa    = false,
        count   = 1,
      }
    }
  }
}