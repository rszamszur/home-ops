resource "proxmox_virtual_environment_group" "puqu-team" {
  comment  = "Managed by Terraform"
  group_id = "puqu"
}

resource "proxmox_virtual_environment_role" "puqu-admin" {
  role_id = "puqu-admin"

  privileges = [
    # Node / System related privileges
    "SDN.Audit",
    "Sys.Audit",
    "Sys.Syslog",
    "Mapping.Audit",
    "Mapping.Use",
    "Pool.Audit",
    # Virtual machine related privileges
    "SDN.Use",
    "VM.Audit",
    "VM.Allocate",
    "VM.Backup",
    "VM.Clone",
    "VM.Config.CDROM",
    "VM.Config.CPU",
    "VM.Config.Cloudinit",
    "VM.Config.Disk",
    "VM.Config.HWType",
    "VM.Config.Memory",
    "VM.Config.Network",
    "VM.Config.Options",
    "VM.Console",
    "VM.Migrate",
    "VM.PowerMgmt",
    "VM.Snapshot.Rollback",
    "VM.Snapshot",
    # Storage related privileges
    "Datastore.Audit",
    "Datastore.AllocateTemplate",
    "Datastore.AllocateSpace"
  ]
}

resource "proxmox_virtual_environment_user" "puqu-user" {
  for_each  = var.puqu_users
  acl {
    path      = "/vms/100"
    propagate = true
    role_id   = "NoAccess"
  }
  acl {
    path     = "/sdn/zones/localnetwork/vmbr0"
    propagate = true
    role_id   = "NoAccess"
  }
  acl {
    path     = "/sdn/zones/localnetwork/vmbr1"
    propagate = true
    role_id   = "NoAccess"
  }
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.puqu-admin.role_id
  }

  enabled  = true
  comment  = "Managed by Terraform"
  password = "a-strong-password"
  email    = each.value.email
  first_name = each.value.first_name
  last_name = each.value.last_name
  user_id  = "${each.value.username}@pve"
  groups   = [proxmox_virtual_environment_group.puqu-team.group_id]
}

resource "proxmox_virtual_environment_role" "csi" {
  role_id = "csi"

  privileges = [
    "Sys.Audit",
    "VM.Audit",
    "VM.Config.Disk",
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "Datastore.Audit",
  ]
}

resource "proxmox_virtual_environment_user" "kubernetes-csi" {
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.csi.role_id
  }

  enabled  = true
  comment  = "Managed by Terraform"
  password = "a-strong-password"
  user_id  = "kubernetes-csi@pve"
}
