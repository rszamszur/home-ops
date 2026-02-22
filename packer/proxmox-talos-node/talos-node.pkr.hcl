packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.7"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "talos-node" {
  proxmox_url              = "https://${var.proxmox_host}:8006/api2/json"
  username                 = var.proxmox_token_id
  token                    = var.proxmox_token_secret
  node                     = var.proxmox_nodename
  insecure_skip_tls_verify = true

  boot_iso {
    iso_storage_pool = "local"
    iso_url  = "https://mirror.rackspace.com/archlinux/iso/2026.02.01/archlinux-2026.02.01-x86_64.iso"
    #iso_file = "local:iso/archlinux-2026.02.01-x86_64.iso"
    iso_download_pve = true
    iso_checksum = "sha256:c0ee0dab0a181c1d6e3d290a81ae9bc41c329ecaa00816ca7d62a685aeb8d972"
    unmount = true
  }
  vm_id = "200"

  network_adapters {
    bridge   = var.proxmox_interface
    model    = "virtio"
    vlan_tag = var.network_vlan_tag
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
  cores = 3
  sockets = 2
  numa = true
  memory   = 12288 
  # vga {
  #   type = "serial0"
  # }
  serials = ["socket"]

  ssh_username = "root"
  ssh_password = "packer"
  ssh_timeout  = "5m"
  qemu_agent   = true

  # ssh_bastion_host       = var.proxmox_host
  # ssh_bastion_username   = "root"
  # ssh_bastion_agent_auth = true

  template_name        = "talos-node"
  template_description = "Talos system disk, version ${var.talos_version}"

  boot_wait = "30s"
  boot_command = [
    "<enter><wait1m>",
    "passwd<enter><wait>packer<enter><wait>packer<enter>"
  ]
}

build {
  name    = "vm-template"
  sources = ["source.proxmox-iso.talos-node"]

  provisioner "shell" {
    inline = [
      "curl -L ${local.image} -o /tmp/talos.raw.xz",
      "xz -d -c /tmp/talos.raw.xz | dd of=/dev/sda && sync",
    ]
  }
}