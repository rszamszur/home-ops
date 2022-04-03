#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
	set -x
fi

set -o errexit
set -o nounset
set -o pipefail

tmp_dir="/tmp/nixery"

if command -v docker &> /dev/null; then
  echo "Found docker-engine."
  container_engine="docker"
elif command -v podman &> /dev/null; then
  echo "Found podman container engine."
  container_engine="podman"
else
  echo "[image] Neither docker nor podman container engine found."
  exit 1
fi

# This is temporary monkey patch to "mock" user space in Nixery container
if [[ -d $tmp_dir ]]; then
  rm -r $tmp_dir
fi
mkdir -p $tmp_dir/etc

cat > /tmp/nixery/etc/hosts << EOF
127.0.0.1  localhost Nixery
::1        localhost
EOF
cat > /tmp/nixery/etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
EOF
cat > /tmp/nixery/etc/group << "EOF"
root:x:0:
EOF

# Run Nixery container with ansible environment
$container_engine run -ti -v /tmp/nixery/etc:/etc -v ../ansible/:/workspace nixery.dev/shell/ansible/ansible-lint/openssh/sshpass bash

