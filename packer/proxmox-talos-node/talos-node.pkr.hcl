packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.7"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox" "talos" {
  proxmox_url              = var.proxmox_api_url
  username                 = var.proxmox_api_token_id
  token                    = var.proxmox_api_token_secret
  node                     = var.proxmox_nodename
  insecure_skip_tls_verify = true

  iso_url          = "https://mirror.rackspace.com/archlinux/iso/2024.02.01/archlinux-2024.02.01-x86_64.iso"
  iso_checksum     = "sha256:891ebab4661cedb0ae3b8fe15a906ae2ba22e284551dc293436d5247220933c5"
  iso_storage_pool = "local"
  unmount_iso = true

  network_adapters {
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = true
  }

  scsi_controller = "virtio-scsi-single"
  disks {
    type         = "scsi"
    storage_pool = var.proxmox_storage
    format       = "raw"
    disk_size    = "5G"
    io_thread    = "true"
    cache_mode   = "writethrough"
  }

  cpu_type = "host"
  memory   = 3072
  # vga {
  #   type = "serial0"
  # }
  serials = ["socket"]

  ssh_username = "root"
  ssh_password = "packer"
  ssh_timeout  = "15m"
  qemu_agent   = true

  # ssh_bastion_host       = var.proxmox_host
  # ssh_bastion_username   = "root"
  # ssh_bastion_agent_auth = true

  template_name        = "talos"
  template_description = "Talos system disk, version ${var.talos_version}"

  boot_wait = "15s"
  boot_command = [
    "<enter><wait1m>",
    "passwd<enter><wait>packer<enter><wait>packer<enter>"
  ]
}

build {
  name    = "talos-node"
  sources = ["source.proxmox.talos"]

  provisioner "shell" {
    inline = [
      "curl -L ${local.image} -o /tmp/talos.raw.xz",
      "xz -d -c /tmp/talos.raw.xz | dd of=/dev/sda && sync",
    ]
  }
}