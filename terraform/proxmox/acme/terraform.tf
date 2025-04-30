terraform {
  backend "kubernetes" {
    secret_suffix    = "proxmox.acme"
    config_path      = "~/.kube/config"
    namespace = "terraform"
  }
}