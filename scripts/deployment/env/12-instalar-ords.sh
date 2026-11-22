#!/usr/bin/env bash
set -euo pipefail
source scripts/deployment/env/00-config.sh
source config/.env
ords="$ORDS_HOME/bin/ords"
if [[ ! -x $ords ]]; then
  curl -fsSL -o /tmp/lab3-ords.zip https://download.oracle.com/otn_software/java/ords/ords-latest.zip
  unzip -qo /tmp/lab3-ords.zip -d "$ORDS_HOME"
fi
"$ords" --version
if [[ ! -f $ORDS_CONFIG/databases/default/pool.xml ]]; then
  printf '%s\n%s\n' "$ORACLE_PWD" "$ORDS_PUBLIC_PWD" | "$ords" --config "$ORDS_CONFIG" install --admin-user SYS --db-hostname localhost --db-port "$PORT_DB" --db-servicename "$SERVICE_PDB" --feature-db-api true --feature-rest-enabled-sql true --feature-sdw true --log-folder "$ORDS_LOGS" --password-stdin
fi
"$ords" --config "$ORDS_CONFIG" config set standalone.http.port "$ORDS_PORT"
"$ords" --config "$ORDS_CONFIG" config set standalone.binds 127.0.0.1
