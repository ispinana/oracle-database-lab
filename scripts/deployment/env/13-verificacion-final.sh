#!/usr/bin/env bash
set -euo pipefail
source scripts/deployment/env/00-config.sh
docker version --format 'Docker cliente {{.Client.Version}} / motor {{.Server.Version}}'
docker image inspect --format '{{json .RepoDigests}}' "$IMG"
docker ps --filter "name=$CONT_NAME" --format '{{.Names}} {{.Status}} {{.Ports}}'
[[ $(docker inspect --format '{{.State.Health.Status}}' "$CONT_NAME") == healthy ]]
[[ $(docker inspect --format '{{range .Mounts}}{{if eq .Destination "/opt/oracle/oradata"}}{{.Name}}{{end}}{{end}}' "$CONT_NAME") == "$VOL_NAME" ]]
docker volume inspect --format '{{.Name}}' "$VOL_NAME"
docker logs "$CONT_NAME" 2>&1 | grep -c 'DATABASE IS READY TO USE'
docker exec -i "$CONT_NAME" sqlplus -s / as sysdba <<'SQL'
WHENEVER SQLERROR EXIT FAILURE
ALTER SESSION SET CONTAINER=FREEPDB1;
SET LINESIZE 140 PAGESIZE 30
COLUMN owner FORMAT A20
SELECT owner,COUNT(*) AS tablas FROM dba_tables WHERE owner IN ('ADMIN_ACADEMIA','ADMIN_CLINICA','ADMIN_FINTECH','ADMIN_LOGISTICA','ADMIN_RETAIL') GROUP BY owner ORDER BY owner;
DECLARE
  correctos NUMBER;
BEGIN
  SELECT COUNT(*) INTO correctos FROM (
    SELECT owner FROM dba_tables WHERE owner IN ('ADMIN_ACADEMIA','ADMIN_CLINICA','ADMIN_FINTECH','ADMIN_LOGISTICA','ADMIN_RETAIL')
    GROUP BY owner HAVING COUNT(*)=CASE owner WHEN 'ADMIN_FINTECH' THEN 2 ELSE 3 END);
  IF correctos<>5 THEN raise_application_error(-20001,'Revisar esquemas'); END IF;
END;
/
EXIT
SQL
bash scripts/deployment/env/09-verificar-java-sqlcl.sh
git check-ignore -q config/.env
if git ls-files --error-unmatch config/.env >/dev/null 2>&1; then exit 1; fi
echo 'Archivo privado excluido de Git'
curl --silent --fail --location --output /dev/null --write-out 'Database Actions HTTP %{http_code}\n' "http://localhost:$ORDS_PORT/ords/sql-developer"
