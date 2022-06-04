{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.talosctl
    pkgs.kubernetes-helm
    pkgs.kubectl
  ];
}
