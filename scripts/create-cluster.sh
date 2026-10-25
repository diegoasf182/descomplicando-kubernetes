#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLUSTER_NAME="giropops"
CONFIG="${ROOT_DIR}/day1/kind/kind-cluster.yaml"

for cmd in docker kind kubectl; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "ERROR: $cmd is not installed."
    exit 1
  fi
done

if ! docker info >/dev/null 2>&1; then
  echo "ERROR: Docker daemon is unavailable."
  exit 1
fi

if kind get clusters | grep -Fxq "$CLUSTER_NAME"; then
  echo "Cluster already exists: $CLUSTER_NAME"
else
  echo "Creating Kind cluster: $CLUSTER_NAME"
  kind create cluster \
    --name "$CLUSTER_NAME" \
    --config "$CONFIG"
fi

kubectl config use-context "kind-${CLUSTER_NAME}"

echo "Waiting for cluster nodes..."
kubectl wait --for=condition=Ready nodes --all --timeout=180s

kubectl get nodes -o wide
