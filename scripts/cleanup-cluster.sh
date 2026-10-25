#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="giropops"

if ! command -v kind >/dev/null 2>&1; then
  echo "ERROR: Kind is not installed."
  exit 1
fi

if kind get clusters | grep -Fxq "$CLUSTER_NAME"; then
  echo "Deleting Kind cluster: $CLUSTER_NAME"
  kind delete cluster --name "$CLUSTER_NAME"
else
  echo "Cluster does not exist: $CLUSTER_NAME"
fi
