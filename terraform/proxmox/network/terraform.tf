terraform {
  backend "kubernetes" {
    secret_suffix    = "proxmox.network"
    config_path      = "~/.kube/config"
    namespace = "terraform"
  }
}