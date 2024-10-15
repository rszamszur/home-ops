#!/usr/bin/env bash

set -euo pipefail

fail() {
  echo "$0:" "$@" >&2
  exit 1
}

require_util() {
  command -v "$1" > /dev/null 2>&1 ||
    fail "'$1' is not installed, which is needed to '$2'"
}

require_util kubectl "run the kubectl commands."
require_util cat "save generated kube config"

# Set variables
CLUSTER_NAME=talos-proxmox
SERVICE_ACCOUNT_NAME=terraform-state
NAMESPACE=terraform
SECRET_NAME=terraform-state-sa-token

# Get the API server URL
SERVER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
# Get the service account token
TOKEN=$(kubectl get secret ${SECRET_NAME} -n ${NAMESPACE} -o jsonpath='{.data.token}' | base64 --decode)
# Get the certificate data
CA_CERT=$(kubectl get secret ${SECRET_NAME} -n ${NAMESPACE} -o jsonpath="{.data['ca\.crt']}")

cat << EOF > ${SERVICE_ACCOUNT_NAME}-kubeconfig
apiVersion: v1
kind: Config
clusters:
- name: ${CLUSTER_NAME}
  cluster:
    certificate-authority-data: ${CA_CERT}
    server: ${SERVER_URL}
contexts:
- name: ${SERVICE_ACCOUNT_NAME}@${CLUSTER_NAME}
  context:
    cluster: ${CLUSTER_NAME}
    namespace: ${NAMESPACE}
    user: ${SERVICE_ACCOUNT_NAME}
current-context: ${SERVICE_ACCOUNT_NAME}@${CLUSTER_NAME}
users:
- name: ${SERVICE_ACCOUNT_NAME}
  user:
    token: ${TOKEN}
EOF
