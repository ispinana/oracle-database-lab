#!/usr/bin/env bash
# Comprueba las evidencias del paso 04 sin volver a aplicar las migraciones.
set -euo pipefail
cd "$(dirname "$0")/../.."
shopt -s nullglob
for migracion in V002__datos_demo_academia V003__cuentas_esquema_sin_password; do
  registros=(docs/bitacora/lab4/evidencia/spool/*_04-"$migracion".spool.log)
  if (( ${#registros[@]} == 0 )); then
    echo "Falta la evidencia de $migracion" >&2
    exit 1
  fi
  registro=${registros[-1]}
  if [[ ! -s "$registro" ]] || grep -Eq '^[[:space:]]*(ORA-|SP2-|PLS-)[0-9]+' "$registro"; then
    echo "Revisa $registro" >&2
    exit 1
  fi
  echo "$migracion: evidencia comprobada en $registro"
done
