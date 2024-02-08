{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gnumake
    pkgs.minikube
    pkgs.kubernetes-helm
    pkgs.jq
    pkgs.kubectl
    pkgs.yamllint
    pkgs.kubeconform
    pkgs.terraform
    pkgs.packer
    pkgs.talosctl
    pkgs.yq
    pkgs.age
    pkgs.sops
  ];
}
