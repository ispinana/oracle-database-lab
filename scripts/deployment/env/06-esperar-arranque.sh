#!/usr/bin/env bash
set -euo pipefail
source scripts/deployment/env/00-config.sh
for ((i=0;i<180;i++)); do
  if [[ $(docker inspect --format '{{.State.Health.Status}}' "$CONT_NAME") == healthy ]]; then
    docker logs "$CONT_NAME" 2>&1 | grep 'DATABASE IS READY TO USE'
    exit 0
  fi
  sleep 5
done
echo 'Tiempo de espera agotado' >&2
exit 1
