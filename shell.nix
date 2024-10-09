{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gnumake
    pkgs.minikube
    pkgs.kubernetes-helm
    pkgs.jq
    pkgs.kubectl
    pkgs.k9s
    pkgs.yamllint
    pkgs.kubeconform
    pkgs.kustomize
    pkgs.terraform
    pkgs.packer
    pkgs.talosctl
    pkgs.yq
    pkgs.age
    pkgs.sops
  ];
}
