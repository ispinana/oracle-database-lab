#!/usr/bin/env bash
set -euo pipefail
source scripts/deployment/env/00-config.sh
source config/.env
export ORACLE_PWD APP_USER_PASSWORD="$APP_USER_PWD"
if ! docker container inspect "$CONT_NAME" >/dev/null 2>&1; then
  docker run -d --name "$CONT_NAME" -p "127.0.0.1:$PORT_DB:1521" -p "127.0.0.1:$PORT_ORDS:8181" -e ORACLE_PWD -e APP_USER=alumno -e APP_USER_PASSWORD -v "$VOL_NAME:/opt/oracle/oradata" "$IMG"
else
  docker start "$CONT_NAME"
fi
docker inspect --format '{{.Name}} {{range .Mounts}}{{.Name}} -> {{.Destination}}{{end}}' "$CONT_NAME"
