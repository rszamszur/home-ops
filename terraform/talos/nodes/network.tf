locals {
  zones = [for k, v in var.instances : k]
  gwv4  = cidrhost(var.vpc_main_cidr, 1)

  controlplane_subnet = cidrsubnet(var.vpc_main_cidr, 5, var.network_shift)
  subnets             = { for inx, zone in local.zones : zone => cidrsubnet(var.vpc_main_cidr, 5, var.network_shift + inx + 1) }
}