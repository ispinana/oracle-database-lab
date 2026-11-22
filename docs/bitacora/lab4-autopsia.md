# Autopsia de la instancia FREE

Inspección del 22 de noviembre de 2026 como C##OPS_RO, después de retirar los objetos de prueba. La raíz y FREEPDB1 estaban abiertas en lectura y escritura. DBID 1518998245.

| Sección | Observación | Riesgo | Acción | Prioridad |
|---|---|---|---|---|
| 4 · Control y redo | Dos control files en el volumen oralab-26ai-data. Tres grupos de redo de 200 MiB, con un miembro cada uno. | Un fallo de volumen afecta a ambas copias de control. Perder un miembro deja el grupo sin redundancia. | Ubicar copias en dominios de fallo distintos y ensayar la pérdida de un miembro en un clon. | Alta |
| 1 y 4 · Recuperación | ARCHIVELOG y FORCE LOGGING activos, FRA sin destino y tamaño 0. | No hay área de recuperación dimensionada. Un destino de archivado lleno puede frenar la base. | Inventariar el destino efectivo, reservar capacidad y comprobar la restauración con redo archivado. | Alta |
| 4 · Diagnóstico | ADR de 7,4 MiB y 60 trazas fuera del volumen. | Al recrear el contenedor se pierde el contexto de incidentes anteriores. | Conservar los eventos y trazas necesarios en almacenamiento persistente con retención. | Media |
| 5 · Capacidad | TBS_ACADEMIA usa 23 de 1024 MiB (2,3 %). | El porcentaje del tablespace no detecta que otros consumidores estén agotando el disco compartido. | Medir también el espacio del volumen y la tasa de crecimiento. | Baja |
| 6 · Índices | En Academia hay 9 índices, ninguno inválido y 2 con factor de agrupamiento cercano al número de filas. | Los recorridos por rango pueden tocar muchos bloques. | Medir buffers y tiempo con predicados representativos antes de proponer un índice. | Baja |
| 10 · Alertas | Cuatro ORA-00800 al asignar prioridad a VKTM y LGWR. Un ORA-65025 al intentar eliminar la PDB abierta y un ORA-959 durante la limpieza del tablespace de prueba. | Los errores provocados enmascaran alertas recurrentes si se agregan por código sin contexto. | Correlacionar por hora y operación. Investigar la prioridad del proceso si aumentan latencias de commit o deriva de reloj. | Media |

## Resumen operativo

Los cinco esquemas sobrevivieron a la recreación y la base vuelve a prestar servicio.  
El riesgo principal es perder varios archivos críticos por el fallo de un único volumen.  
La siguiente comprobación de continuidad debe medir cuánto tardaría una restauración completa.

Evidencias: [20261122T132809Z_15-autopsia-instancia.spool.log](lab4/evidencia/spool/20261122T132809Z_15-autopsia-instancia.spool.log), [20261122T132801Z_11-archivos-so.script.log](lab4/evidencia/script/20261122T132801Z_11-archivos-so.script.log), [20261122T132732Z_06-alert-log.script.log](lab4/evidencia/script/20261122T132732Z_06-alert-log.script.log), [20261122T132810Z_16-verificacion-final.script.log](lab4/evidencia/script/20261122T132810Z_16-verificacion-final.script.log).
