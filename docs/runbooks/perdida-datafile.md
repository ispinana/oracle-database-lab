# Guardia Oracle · Pérdida de un datafile de aplicación

**Reconocer el incidente.** ORA-01116 indica que Oracle no puede abrir un archivo. ORA-01110 identifica su número y ruta, y ORA-27041 recoge el fallo del sistema operativo. ORA-63999 puede acompañar al cierre preventivo de la PDB. Anota la hora, el tablespace, el número de archivo y las aplicaciones afectadas. Avisa al DBA de guardia y al responsable del servicio. Si el almacenamiento sigue fallando, involucra al equipo de sistemas antes de restaurar.

**Confirmar la cobertura.** Desde la raíz, con SQL*Plus como SYSDBA, identifica la PDB y el archivo. Sustituye `<n>` por el número confirmado durante el diagnóstico.

```sql
SELECT log_mode FROM v$database;
SELECT name, open_mode FROM v$pdbs;
SELECT file#, con_id, name FROM v$datafile ORDER BY con_id, file#;
```

En RMAN conectado a la raíz, ejecuta `LIST BACKUP OF DATAFILE <n>;` y `RESTORE DATAFILE <n> PREVIEW;`. Confirma que están disponibles las piezas y la cadena de redo y que el destino tiene espacio. Si falta cobertura, escala antes de modificar el estado. SYSTEM y los archivos críticos requieren un procedimiento de recuperación con la base montada.

**Aislar y recuperar.** Si FREEPDB1 sigue en READ WRITE, entra en ella con SQL*Plus y ejecuta `ALTER DATABASE DATAFILE <n> OFFLINE;`. Si Oracle está cerrando la PDB, espera a que figure MOUNTED. Con la PDB ya montada, continúa directamente con RMAN desde la raíz.

```text
RESTORE DATAFILE <n>;
RECOVER DATAFILE <n>;
```

Verifica el final de la recuperación de medios. En SQL*Plus, entra en FREEPDB1 y ejecuta `ALTER DATABASE DATAFILE <n> ONLINE;`. Si la PDB quedó montada, vuelve a CDB$ROOT y ejecuta `ALTER PLUGGABLE DATABASE FREEPDB1 OPEN;`.

**Devolver el servicio.** Comprueba READ WRITE en `v$pdbs` y la ausencia del archivo en `v$recover_file`. En FREEPDB1 consulta la fila 104 de `admin_academia.aca_estudiantes`. En el simulacro debe conservar EGRESADO, confirmado después de la copia. Registra el valor antes de devolverlo a ACTIVO, comprueba las 60 000 matrículas y comunica el RTO y los cambios recuperados al responsable del servicio.

