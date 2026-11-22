WHENEVER SQLERROR EXIT FAILURE
ALTER SESSION SET CONTAINER=FREEPDB1;
SET LINESIZE 160
SELECT force_matching_signature, COUNT(DISTINCT sql_id) cursores, MIN(SUBSTR(sql_text,1,70)) ejemplo
FROM v$sql WHERE force_matching_signature <> 0 GROUP BY force_matching_signature
HAVING COUNT(DISTINCT sql_id)>50 ORDER BY cursores DESC;
EXIT
