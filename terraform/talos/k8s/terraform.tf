terraform {
  backend "kubernetes" {
    secret_suffix    = "talos.k8s"
    config_path      = "~/.kube/config"
    namespace = "terraform"
  }
}