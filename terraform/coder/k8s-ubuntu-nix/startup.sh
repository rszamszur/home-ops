#!/usr/bin/env bash
set -eu

# install and start code-server
curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/tmp/code-server --version 4.11.0
/tmp/code-server/bin/code-server --auth none --port 13337 >/tmp/code-server.log 2>&1 &

# install nix
WORKDIR=$(mktemp -d)
NIX_VERSION="2.23.3"
NIX_CHANNEL="https://nixos.org/channels/nixpkgs-unstable"
NIX_INSTALLER_OUT="${WORKDIR}/install"

cd ${WORKDIR}

# Fetch the nix installer
curl -o ${NIX_INSTALLER_OUT} --fail -L "https://releases.nixos.org/nix/nix-${NIX_VERSION}/install"
chmod 755 ${NIX_INSTALLER_OUT}

cat > ${WORKDIR}/nix.conf << EOF
build-users-group = coder
trusted-users = root coder
experimental-features = nix-command flakes
substituters = https://cache.nixos.org/ https://nix-community.cachix.org ssh-ng://nix-rbe
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= tyr:bbjBCfYPxGt0i2LGCDy802CbgqkRRoRGL2h3u7QVeVg=
EOF

if [[ ! -e "${HOME}/.bash_profile" ]]; then
  touch ${HOME}/.bash_profile
fi

${NIX_INSTALLER_OUT} --no-daemon --no-channel-add --yes

. /home/coder/.nix-profile/etc/profile.d/nix.sh
nix-channel --add ${NIX_CHANNEL} nixpkgs
nix-channel --update

cd -
rm -rf ${WORKDIR}
