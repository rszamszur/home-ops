locals {
  worker_prefix = "worker"
  workers = { for k in flatten([
    for zone in local.zones : [
      for inx in range(lookup(try(var.instances[zone]["worker"], {}), "count", 0)) : {
        id : lookup(try(var.instances[zone]["worker"], {}), "id", 9000) + inx
        name : "${lower(zone)}-talos-${local.worker_prefix}-${1 + inx}"
        zone : zone
        node_name : zone
        cpu : lookup(try(var.instances[zone]["worker"], {}), "cpu", 1)
        mem : lookup(try(var.instances[zone]["worker"], {}), "mem", 2048)
        ipv4 : "${cidrhost(local.subnets[zone], 3 + inx)}/24"
        gwv4 : local.gwv4
      }
    ]
  ]) : k.name => k }
}

resource "proxmox_virtual_environment_vm" "talos-worker" {
  for_each  = local.workers
  name      = each.value.name
  tags      = ["talos-worker"]
  node_name = each.value.node_name
  vm_id     = each.value.id

  initialization {
    datastore_id = var.proxmox_storage
    ip_config {
      ipv4 {
        address = each.value.ipv4
        gateway = each.value.gwv4
      }
    }
  }
  boot_order = ["scsi0"]
  clone {
    vm_id = var.proxmox_vm_template_id
  }
  disk {
    datastore_id = var.proxmox_storage
    interface    = "scsi0"
    ssd          = true
    size         = 32
    file_format  = "raw"
  }
  cpu {
    cores   = each.value.cpu
    sockets = 1
    type    = "host"
    flags   = ["+aes"]
  }
  memory {
    dedicated = each.value.mem
  }

  network_device {
    model   = "virtio"
    bridge  = "vmbr0"
    vlan_id = "3"
    # firewall = true
  }

  operating_system {
    type = "l26"
  }
  agent {
    enabled = false
  }

  serial_device {}
  lifecycle {
    ignore_changes = [
      tags,
      cpu,
      memory,
      network_device,
    ]
  }

}