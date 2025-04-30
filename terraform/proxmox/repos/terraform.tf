terraform {
  backend "kubernetes" {
    secret_suffix    = "proxmox.repos"
    config_path      = "~/.kube/config"
    namespace = "terraform"
  }
}