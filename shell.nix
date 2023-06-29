{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.minikube
    pkgs.kubernetes-helm
    pkgs.jq
    pkgs.kubectl
    pkgs.yamllint
    pkgs.kubeconform
  ];
}
