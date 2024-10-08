terraform {
  backend "kubernetes" {
    secret_suffix    = "talos.nodes"
    config_path      = "~/.kube/config"
    namespace = "terraform"
  }
}