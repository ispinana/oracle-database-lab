#!/usr/bin/env bash
set -euo pipefail
source scripts/deployment/env/00-config.sh
if ! tmux has-session -t ords 2>/dev/null; then
  tmux new-session -d -s ords "exec '$ORDS_HOME/bin/ords' --config '$ORDS_CONFIG' serve >> '$ORDS_LOGS/ords-serve.log' 2>&1"
fi
for ((i=0;i<90;i++)); do
  response=$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:$ORDS_PORT/ords/sql-developer" || true)
  case "$response" in 2??|3??) echo "Database Actions: HTTP $response"; ss -ltn "sport = :$ORDS_PORT"; exit 0;; esac
  sleep 2
done
exit 1
