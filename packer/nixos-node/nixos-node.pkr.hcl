packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.7"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "nixos-node" {
  proxmox_url              = "https://${var.proxmox_host}:8006/api2/json"
  username                 = var.proxmox_token_id
  token                    = var.proxmox_token_secret
  node                     = var.proxmox_nodename
  insecure_skip_tls_verify = true
  task_timeout             = "5m"

  bios = "ovmf"
  efi_config {
    efi_storage_pool = var.proxmox_storage
  }

  boot_iso {
    iso_storage_pool = "local"
    iso_url = var.nixos_iso
    #iso_file = "local:iso/nixos-minimal-25.05.20251016.98ff3f9-x86_64-linux.iso"
    iso_download_pve = true
    iso_checksum = var.nixos_iso_checksum
    unmount = true
  }
  vm_id = "300"

  network_adapters {
    bridge   = var.proxmox_interface
    model    = "virtio"
    firewall = true
    vlan_tag = var.network_vlan_tag
  }

  scsi_controller = "virtio-scsi-single"
  disks {
    type         = "scsi"
    storage_pool = var.proxmox_storage
    format       = "raw"
    disk_size    = "150G"
    io_thread    = "true"
    cache_mode   = "writethrough"
  }

  cpu_type = "host"
  cores = 4
  sockets = 2
  numa = true
  memory   = 16384
  serials = ["socket"]

  ssh_username = "root"
  ssh_password = "packer"
  ssh_timeout  = "5m"
  qemu_agent   = true

  template_name        = "nixos-node"
  template_description = "NixOS Tyr host"

  boot_wait = "60s"
  boot_command = [
    "<enter>",
    "sudo -i<enter>",
    "passwd<enter><wait>packer<enter><wait>packer<enter>",
  ]
}

build {
  name    = "vm-template"
  sources = ["source.proxmox-iso.nixos-node"]

  provisioner "shell" {
    inline = [
      "curl -s https://raw.githubusercontent.com/rszamszur/nixos-config/master/hosts/tyr/install.sh | bash"
    ]
  }
}