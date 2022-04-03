#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
  echo "Stocker config dir param is required"
  exit 1
elif [[ -z "$1" ]]; then
  echo "Parameter empty"
  exit 1
fi

echo -e "Generated k8s job manifest from template:\n"
export STOCKER_CONFIG_DIR=$1
generated_id=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c8)
filename="backtest_$generated_id.yml"
envsubst '$STOCKER_CONFIG_DIR' < template-backtest-job.yml > $filename
cat $filename


if [[ $2 == "deploy" ]]; then
  echo -e "Run job in k8s cluster\n"
  kubectl create -f $filename
fi

