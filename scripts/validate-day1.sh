#!/usr/bin/env bash
set -euo pipefail

CONTEXT="kind-giropops"
POD="giropops"
NAMESPACE="default"

echo "Validating Kubernetes Day 1 laboratory..."

for cmd in kubectl; do
  command -v "$cmd" >/dev/null || {
    echo "ERROR: Missing $cmd"
    exit 1
  }
done

CURRENT_CONTEXT=$(kubectl config current-context)

if [[ "$CURRENT_CONTEXT" != "$CONTEXT" ]]; then
  echo "ERROR: Unexpected Kubernetes context: $CURRENT_CONTEXT"
  exit 1
fi

echo "[1/4] Validating cluster nodes..."

kubectl wait \
  --context "$CONTEXT" \
  --for=condition=Ready \
  nodes --all \
  --timeout=180s

NODE_COUNT=$(kubectl --context "$CONTEXT" \
  get nodes --no-headers | wc -l)

if [[ "$NODE_COUNT" -ne 3 ]]; then
  echo "ERROR: Expected 3 nodes, found $NODE_COUNT"
  exit 1
fi

echo "[2/4] Validating Pod readiness..."

kubectl --context "$CONTEXT" -n "$NAMESPACE" wait \
  --for=condition=Ready \
  "pod/$POD" \
  --timeout=180s

READY_COUNT=$(kubectl --context "$CONTEXT" -n "$NAMESPACE" \
  get pod "$POD" \
  -o jsonpath='{.status.containerStatuses[?(@.ready==true)].name}' \
  | wc -w)

if [[ "$READY_COUNT" -ne 2 ]]; then
  echo "ERROR: Expected 2 ready containers."
  exit 1
fi

echo "[3/4] Testing NGINX HTTP endpoint..."

kubectl --context "$CONTEXT" -n "$NAMESPACE" \
  exec "$POD" -c nginx -- \
  curl -fsS -o /dev/null \
  -w 'NGINX HTTP status: %{http_code}\n' \
  http://127.0.0.1:80/

echo "[4/4] Testing Apache HTTP endpoint..."

kubectl --context "$CONTEXT" -n "$NAMESPACE" \
  exec "$POD" -c nginx -- \
  curl -fsS -o /dev/null \
  -w 'Apache HTTP status: %{http_code}\n' \
  http://127.0.0.1:8080/

echo "All Day 1 validation checks passed."
