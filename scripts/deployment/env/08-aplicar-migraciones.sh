#!/usr/bin/env bash
set -euo pipefail
source scripts/deployment/env/00-config.sh
for migration in V000__setup_entornos_negocio V001__create_esquemas_negocio; do
  docker exec -i "$CONT_NAME" sqlplus -s / as sysdba < "database/migrations/$migration.sql" | tee "$EVID/spool/$(ts)_08-$migration.spool.log"
done
