terraform {
  backend "kubernetes" {
    secret_suffix    = "ovh"
    config_path      = "~/.kube/config"
    namespace = "terraform"
  }
}