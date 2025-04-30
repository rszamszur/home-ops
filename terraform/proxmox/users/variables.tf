variable "proxmox_host" {
  description = "Proxmox host"
  type        = string
  default     = "192.168.10.11"
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

variable "puqu_users" {
  description = "Proxmox puqu users"
  type = map(object({
    first_name = string
    last_name = string
    email = string
    username = string
  }))
  default = {
    r2r = {
      username = "r2r"
      first_name = "Artur"
      last_name = "Stachecki"
      email = "proxmox@r2r.sh"
    },
    alex = {
      username = "alex"
      first_name = "Aleksander"
      last_name = "Gondek"
      email = "proxmox@other-songs.eu"
    },
    suwara = {
      username = "suwara"
      first_name = "Michal"
      last_name = "Suwara"
      email = "suwara.michal+proxmox@asml.com"
    },
    konrad = {
      username = "konrad"
      first_name = "Konrad"
      last_name = "Kolodziejczyk"
      email = "konrad.kk+proxmox@gmail.com"
    }
  }
}