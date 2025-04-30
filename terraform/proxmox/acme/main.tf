resource "proxmox_virtual_environment_acme_account" "letsencrypt" {
  name      = "letsencrypt"
  contact   = "acme@szamszur.cloud"
  directory = "https://acme-v02.api.letsencrypt.org/directory"
  tos       = "https://letsencrypt.org/documents/LE-SA-v1.5-February-24-2025.pdf"
}

resource "proxmox_virtual_environment_acme_dns_plugin" "acme-ovh" {
  plugin = "ACME-OVH"
  api    = "OVH"
  data = {
    OVH_AK = var.ovh_application_key
    OVH_AS = var.ovh_application_secret
    OVH_CK = var.ovh_consumer_key
    OVH_END_POINT = "ovh-eu"
  }
}
