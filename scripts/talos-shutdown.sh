#!/usr/bin/env bash

set -eou pipefail

echo "Shutdown talos-proxmox"
talosctl --talosconfig ~/.talos/config shutdown -n 192.168.20.16 -n 192.168.20.17 -n 192.168.20.18 -n 192.168.20.19
talosctl --talosconfig ~/.talos/config shutdown -n 192.168.20.8
