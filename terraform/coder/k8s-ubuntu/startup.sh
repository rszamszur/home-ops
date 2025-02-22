#!/usr/bin/env bash
set -eu

# helper functions
ensure_env_set() {
  local var=$1
  if [ -z "${!var}" ]; then
    echo "$1 variable not set" >&2
    exit 1
  fi
}
require_util() {
  command -v "$1" > /dev/null 2>&1 ||
    fail "'$1' is not installed, which is needed to '$2'"
}

# Ensure required utils are present
require_util jq "parse coder API response"
require_util curl "fetching and calling remote resources"
# Ensure required env variables are set
ensure_env_set "CODER_AGENT_URL"
ensure_env_set "CODER_AGENT_TOKEN"

# Coder setup environment variables
CODER_AGENT_HEADER="cookie: coder_session_token=${CODER_AGENT_TOKEN}"
CODER_SSH_KEY_API_ENDPOINT="${CODER_AGENT_URL}api/v2/workspaceagents/me/gitsshkey"

# Ensure ~/.ssh exists and has correct permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh
rm -f ~/.ssh/id_ed25519.pub ~/.ssh/id_ed25519

# Fetch Coder ssh key
curl \
  --silent \
  --fail \
  --show-error \
  --request GET \
  --header "${CODER_AGENT_HEADER}" \
  --header "Content-Type: application/json" \
  "${CODER_SSH_KEY_API_ENDPOINT}" > response

# Ensure ~/.ssh/id_ed25519 exists and has correct permissions
jq -r '.private_key' < response > ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519

# Ensure ~/.ssh/id_ed25519.pub exists and has correct permissions
jq -r '.public_key' < response > ~/.ssh/id_ed25519.pub
chmod 644 ~/.ssh/id_ed25519.pub

rm -f response

# install and start code-server
curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/tmp/code-server --version 4.11.0
/tmp/code-server/bin/code-server --auth none --port 13337 >/tmp/code-server.log 2>&1 &
