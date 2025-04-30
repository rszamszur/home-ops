terraform {
  backend "kubernetes" {
    secret_suffix    = "proxmox.users"
    config_path      = "~/.kube/config"
    namespace = "terraform"
  }
}