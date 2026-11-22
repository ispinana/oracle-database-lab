# Lab 4 · Respuestas

## Preguntas de comprobación

1. SHUTDOWN IMMEDIATE completó el checkpoint, deshizo transacciones pendientes y cerró los archivos antes de copiar el volumen. Con la base abierta, archivos copiados en momentos distintos pueden exigir redo para recuperar una imagen consistente. [20261122T132459Z_00-backup-lab3.script.log](lab4/evidencia/script/20261122T132459Z_00-backup-lab3.script.log)

2. El manifiesto identifica versión de código, imagen, volumen, fecha y tipo de copia. SHA256SUMS verifica cada byte archivado frente a su huella. El restaurador valida integridad y requisitos antes de sustituir el volumen. [20261122T132459Z_00-backup-lab3.script.log](lab4/evidencia/script/20261122T132459Z_00-backup-lab3.script.log)

3. El RPO es la pérdida de trabajo aceptable y el RTO es el tiempo máximo aceptable para recuperar servicio. La copia de las 13:25 UTC cubre el estado del Lab 3 y ocupa 488 MiB. Sin aplicar redo posterior se perderían los cambios desde su cierre. La sonda detectó servicio diez segundos después del arranque. Esa cifra excluye restaurar el archivo y verificarlo; el RTO completo queda por medir en un simulacro. [20261122T132459Z_00-backup-lab3.script.log](lab4/evidencia/script/20261122T132459Z_00-backup-lab3.script.log)

4. V000 usó nombres relativos y Oracle los registró bajo $ORACLE_HOME/dbs. En esta imagen readlink resolvió esos archivos dentro del volumen, aunque fuera de la carpeta estándar de FREEPDB1. Para nuevas altas sin nombre físico se configuró DB_CREATE_FILE_DEST y Oracle Managed Files. [20261122T132636Z_01-diagnostico.script.log](lab4/evidencia/script/20261122T132636Z_01-diagnostico.script.log)

5. RENAME DATAFILE actualiza la referencia del control file. La copia física requiere poner offline el tablespace, copiar el archivo, registrar la ruta nueva y volver online. Solo entonces se retira la copia de la ubicación antigua. [20261122T132657Z_03-reubicar-datafiles.script.log](lab4/evidencia/script/20261122T132657Z_03-reubicar-datafiles.script.log)

6. Una base instalada ya ejecutó V000. V003 transforma esas cuentas en propietarias sin autenticación directa con NO AUTHENTICATION. Eliminar un literal del repositorio no revoca una credencial activa. En esta instalación V000 ya generaba claves distintas. [20261122T132716Z_04-V003__cuentas_esquema_sin_password.spool.log](lab4/evidencia/spool/20261122T132716Z_04-V003__cuentas_esquema_sin_password.spool.log)

7. Antes y después de reemplazar el contenedor aparecieron los cinco esquemas con 3, 3, 2, 3 y 3 tablas. Recrearlo tras comprobar el respaldo y las rutas demuestra que el nuevo proceso recupera el estado desde el volumen. [20261122T132700Z_03-prueba-persistencia.script.log](lab4/evidencia/script/20261122T132700Z_03-prueba-persistencia.script.log)

8. Instancia: nombre FREE, host 923c4c44e1e6 y arranque a las 13:27:07 UTC. Base: DBID 1518998245, creación 2026-10-18 y modo ARCHIVELOG. El DBID permanece cuando cambia el proceso que monta los archivos. [20261122T132722Z_05-instancia-y-base.spool.log](lab4/evidencia/spool/20261122T132722Z_05-instancia-y-base.spool.log)

9. En NOMOUNT ya se ha leído el fichero de parámetros y existe la SGA, pero V$DATABASE devuelve ORA-01507. MOUNT abre los control files y conoce los datafiles; DBA_TABLES todavía devuelve ORA-01219. OPEN abre los archivos de datos y redo y permite leer el diccionario. [20261122T132724Z_06-arranque-por-etapas.script.log](lab4/evidencia/script/20261122T132724Z_06-arranque-por-etapas.script.log)

10. V$PARAMETER mostraba DB_FILES=200 mientras V$SPPARAMETER registraba 300 para el arranque siguiente. RESET quitó la entrada persistente y dejó intacto el valor efectivo de 200. [20261122T132736Z_07-parametros-cambios.script.log](lab4/evidencia/script/20261122T132736Z_07-parametros-cambios.script.log)

11. Una indicación genérica de modificabilidad no garantiza que el valor ni el ámbito propuestos sean válidos para la instancia actual. PROCESSES dimensiona estructuras al arrancar. La prueba SCOPE=MEMORY recibió ORA-02097/02095 y no cambió la configuración. [20261122T132736Z_07-parametros-cambios.script.log](lab4/evidencia/script/20261122T132736Z_07-parametros-cambios.script.log)

12. MEMORY_TARGET=0, SGA_TARGET=1536M y PGA_AGGREGATE_TARGET=512M. ASMM redistribuye componentes de la SGA y la PGA se gestiona con su propio objetivo. [20261122T132739Z_08-memoria.spool.log](lab4/evidencia/spool/20261122T132739Z_08-memoria.spool.log)

13. Las dos rondas devolvieron 17 600 estudiantes activos. En frío hubo 359 lecturas lógicas y 261 físicas, aproximadamente un 27,3 % de acierto según 1−261/359. En caliente hubo 247 lógicas y cero físicas, un 100 % según la misma métrica de sesión. [20261122T132739Z_08-experimento-cache.script.log](lab4/evidencia/script/20261122T132739Z_08-experimento-cache.script.log)

14. Los literales generaron 1008 análisis duros y 590 ms de CPU de análisis. Con :id hubo un análisis duro y un cursor para 1000 ejecuciones. Al muestrear V$SQL quedaban 490 cursores literales y ocupaban 17 623 KiB. Algunos ya se habían expulsado de la shared pool. [20261122T132739Z_08-parse-y-pga.script.log](lab4/evidencia/script/20261122T132739Z_08-parse-y-pga.script.log)

15. LGWR tenía PID 616 dentro del contenedor, el mismo identificador que el SPID de Oracle. Docker top muestra los PID del espacio de nombres del host. Se deben comparar procesos dentro del mismo espacio. [20261122T132746Z_09-procesos-so.script.log](lab4/evidencia/script/20261122T132746Z_09-procesos-so.script.log)

16. SYS desde la raíz ve los 16 datafiles de raíz, semilla y PDB. La misma consulta en FREEPDB1 ve sus nueve archivos. El ámbito cambia aunque las sesiones pertenezcan al mismo administrador. [20261122T132747Z_10-que-ve-cada-usuario.script.log](lab4/evidencia/script/20261122T132747Z_10-que-ve-cada-usuario.script.log)

17. Sin permiso sobre el objeto, Oracle oculta incluso su existencia al analista. Por eso la consulta de SYS.DBA_TABLES devuelve ORA-00942. Al intentar actualizar una tabla visible con solo READ, la operación se rechaza con ORA-41900. [20261122T132747Z_10-que-ve-cada-usuario.script.log](lab4/evidencia/script/20261122T132747Z_10-que-ve-cada-usuario.script.log)

18. Un usuario común puede existir en varias PDB y seguir viendo solo las filas de la raíz desde una vista CDB_. OPS_RO tiene CONTAINER_DATA ampliado. Para igualar esa visibilidad se usaría ALTER USER c##lab4_auditor SET CONTAINER_DATA=ALL CONTAINER=CURRENT en la raíz. [20261122T132747Z_10-que-ve-cada-usuario.script.log](lab4/evidencia/script/20261122T132747Z_10-que-ve-cada-usuario.script.log)

19. READ ANY TABLE ON SCHEMA concede lectura sobre las tablas presentes y futuras de un esquema. Simplifica el mantenimiento, pero una tabla sensible creada después quedaría automáticamente al alcance de ese lector. [20261122T132747Z_10-que-ve-cada-usuario.script.log](lab4/evidencia/script/20261122T132747Z_10-que-ve-cada-usuario.script.log)

20. COMMON_USER_PREFIX vale C##. Intentar un nombre local con ese prefijo dentro de una PDB produjo ORA-65094. En la raíz, un nombre común que incumplía el prefijo produjo ORA-65096. [20261122T132752Z_10-ciclo-detalle.script.log](lab4/evidencia/script/20261122T132752Z_10-ciclo-detalle.script.log)

21. Los archivos físicos de la base incluyen datafiles, tempfiles, control files y online redo. El SPFILE, el password file y los diagnósticos cumplen funciones de arranque, autenticación y operación. El password file permite autenticación administrativa remota y debe protegerse en el respaldo. [20261122T132801Z_11-archivos.spool.log](lab4/evidencia/spool/20261122T132801Z_11-archivos.spool.log)

22. Los 100 MiB declarados equivalen a 104 857 600 bytes. El fichero de Linux mide 104 865 792, una diferencia de 8192 bytes por el bloque de cabecera del fichero. [20261122T132801Z_11-archivos-so.script.log](lab4/evidencia/script/20261122T132801Z_11-archivos-so.script.log)

23. Los dos control files residen en el mismo volumen. Un fallo del dispositivo alcanza ambas copias. Cada uno de los tres grupos de redo tiene un único miembro; perderlo puede comprometer la recuperación. [20261122T132801Z_11-archivos.spool.log](lab4/evidencia/spool/20261122T132801Z_11-archivos.spool.log)

24. El ADR ocupa 7,4 MiB en la capa del contenedor. Recrearlo conserva los datos del volumen, pero elimina alertas y trazas históricas necesarias para reconstruir una incidencia. [20261122T132801Z_11-archivos-so.script.log](lab4/evidencia/script/20261122T132801Z_11-archivos-so.script.log)

25. AAAR8iAAAAAAAMMAAF identifica el objeto 73506. DBMS_ROWID resolvió el archivo absoluto 16, bloque BIGFILE 780 y slot 5. El volcado físico coincide con ese bloque y la fila de estudiante 101. [20261122T132801Z_12-bloque.script.log](lab4/evidencia/script/20261122T132801Z_12-bloque.script.log)

26. nrow=90 cuenta entradas de fila. fsbo es el inicio del espacio libre después del directorio de filas y fseo su extremo junto a los datos. 0x427−0xc6=0x361, es decir, 865 bytes de avsp. [20261122T132801Z_12-bloque.script.log](lab4/evidencia/script/20261122T132801Z_12-bloque.script.log)

27. La ITL conserva la transacción asociada a 90 filas. --U- indica un commit cuyo estado aún necesita limpieza en el bloque. Un lector posterior puede completar la limpieza al verificar el estado de la transacción. Lck=90 no prueba que 90 filas sigan bloqueadas por una sesión activa. [20261122T132801Z_12-bloque.script.log](lab4/evidencia/script/20261122T132801Z_12-bloque.script.log)

28. La suma de los valores almacenados de las siete columnas dio 68 bytes. A ellos se añaden tres bytes de cabecera y siete indicadores de longitud de un byte. Total 78 bytes, aparte de la entrada del directorio de filas. [20261122T132801Z_12-bloque.script.log](lab4/evidencia/script/20261122T132801Z_12-bloque.script.log)

29. Con 8192 bytes, cabecera de 96, PCTFREE 10 y fila media de 76, caben floor((8192−96)×0,9/76)=95 filas. Harían falta ceil(20000/95)=211 bloques. La estimación con más cabecera y slots dio 216. Los 244 bajo la marca de agua incluyen ocupación desigual, estructuras y espacio libre. [20261122T132803Z_13-capacidad.script.log](lab4/evidencia/script/20261122T132803Z_13-capacidad.script.log)

30. En 5a, 590 ms de CPU/400 000 lecturas ≈1,48 µs por lógica. En 5b, 32,3 ms/5464 ≈5,9 µs por física aleatoria. En 5c, 18 ms/4595 ≈3,9 µs por bloque secuencial, amortizando cada petición multibloque. [20261122T132803Z_13-capacidad.script.log](lab4/evidencia/script/20261122T132803Z_13-capacidad.script.log)

31. Con 150 MiB/s se tarda 0,0521 ms por bloque de 8 KiB. Frente a 5 ms aleatorios y con bfr=86, el umbral aproximado es (0,0521/5)/86=0,000121, o 0,0121 % de filas. Si MB significa decimal, resulta 0,0127 %. [20261122T132803Z_13-capacidad.script.log](lab4/evidencia/script/20261122T132803Z_13-capacidad.script.log)

32. FLUSH BUFFER_CACHE vacía la caché de Oracle; Linux y el almacenamiento subyacente pueden seguir teniendo las páginas. La medición caracteriza esta pila de E/S. Para extrapolarla a un HDD físico habría que volver a medir en ese equipo. [20261122T132803Z_13-capacidad.script.log](lab4/evidencia/script/20261122T132803Z_13-capacidad.script.log)

33. La migración deja un puntero tras un UPDATE que ya no cabe. El encadenamiento divide una fila demasiado grande en varias piezas. ANALYZE y continued-row fetches ayudan a detectarlas. MOVE con margen reparó MIGRA; la fila de unos 12 000 bytes de ANCHA necesita bloques mayores o rediseño. [20261122T132805Z_14-filas-migradas.script.log](lab4/evidencia/script/20261122T132805Z_14-filas-migradas.script.log)

34. De 1000 búsquedas, 200 siguieron un puntero adicional. A las tres lecturas base por búsqueda se suman 200/1000=0,2. El contador registró 3200 lecturas lógicas en total. [20261122T132805Z_14-filas-migradas.script.log](lab4/evidencia/script/20261122T132805Z_14-filas-migradas.script.log)

35. MOVE cambia los ROWID y deja referencias antiguas en el índice. PK_MIGRA quedó UNUSABLE. En producción planificaría reconstrucción y verificación de índices o un MOVE ONLINE compatible con la edición y el margen disponible. [20261122T132805Z_14-filas-migradas.script.log](lab4/evidencia/script/20261122T132805Z_14-filas-migradas.script.log)

36. Prioridad alta: separar las copias del control file y los miembros de redo en dominios de fallo distintos. Alta: verificar recuperación desde ARCHIVELOG con un destino supervisado. Media: investigar las cuatro ORA-00800 y su impacto temporal antes de cambiar privilegios del contenedor. [20261122T132809Z_15-autopsia-instancia.spool.log](lab4/evidencia/spool/20261122T132809Z_15-autopsia-instancia.spool.log)

37. OPS_RO lee las vistas necesarias y el alert log con un permiso puntual. El verificador encontró cero privilegios ANY de escritura. Una consulta de observabilidad no necesita la capacidad de SYSTEM para modificar datos o configuración. [20261122T132810Z_16-verificacion-final.script.log](lab4/evidencia/script/20261122T132810Z_16-verificacion-final.script.log)

38. V003 elimina el inicio de sesión por contraseña de las cinco cuentas propietarias. El ejecutor de migraciones usa autenticación del SO sin pasar SYS/contraseña por la línea de comandos. Al recrear la base existente tampoco se inyectó la clave en el entorno Docker. [20261122T132810Z_16-verificacion-final.script.log](lab4/evidencia/script/20261122T132810Z_16-verificacion-final.script.log)

## Retos profesionales

- **Diagnóstico inicial.** Primero se protegieron los datos con una copia en frío (riesgo alto). Después se normalizaron las rutas de los cinco datafiles y se probaron al recrear el contenedor (medio). Se retiró el puerto 8181 y se deshabilitó el acceso directo a los esquemas propietarios. [20261122T132636Z_01-diagnostico.script.log](lab4/evidencia/script/20261122T132636Z_01-diagnostico.script.log)

- **Rol de observación.** Con DBA una sesión de diagnóstico podría alterar tablas o conferir privilegios a terceros. Para leer el alert log basta el permiso puntual SELECT sobre SYS.V_$DIAG_ALERT_EXT en el ámbito necesario. [20261122T132657Z_02-cuenta-observabilidad.script.log](lab4/evidencia/script/20261122T132657Z_02-cuenta-observabilidad.script.log)

- **Archivos nuevos.** En FREEPDB1 se aplicó ALTER SYSTEM SET db_create_file_dest='/opt/oracle/oradata' SCOPE=BOTH. CREATE TABLESPACE sin cláusula DATAFILE permite a OMF generar nombre y destino en el volumen. Un nombre explícito exige revisar igualmente la ruta. [20261122T132716Z_03-destino-omf.script.log](lab4/evidencia/script/20261122T132716Z_03-destino-omf.script.log)

- **Parte de reinicio.** Parada solicitada a las 13:27:24.852 UTC y OPEN a las 13:27:32.752, 7,90 s. El cierre fue ordenado y el alert log excluyó las PDB cerradas limpiamente de crash recovery. Los ORA-00800 conciernen a prioridades del SO. Se investigarían si coinciden con latencia. [20261122T132851Z_06-tiempos.script.log](lab4/evidencia/script/20261122T132851Z_06-tiempos.script.log)

- **Petición sobre cursores.** Partir de 300 y localizar la sesión que acumula cursores con V$OPEN_CURSOR. Reproducir ORA-01000 bajo carga. Solo si hay demanda legítima, probar 1000 en memoria en la PDB afectada, medir abiertos y consumo antes/después y persistir con BOTH tras validar. Para revertir, restaurar el valor o quitar el override local para heredar de la raíz. [20261122T132736Z_07-parametros-cambios.script.log](lab4/evidencia/script/20261122T132736Z_07-parametros-cambios.script.log)

- **Literales.** La consulta agrupada por FORCE_MATCHING_SIGNATURE encontró 451 SQL_ID para la familia lab4_literal en el instante de la segunda muestra. [20261122T132740Z_08-reto-literales.script.log](lab4/evidencia/script/20261122T132740Z_08-reto-literales.script.log)

- **Sesión activa.** Durante el cruce de ACA_MATRICULAS con filtro a.matricula_id < 3000, OPS_RO localizó el módulo LAB4_MEDICION, SID 217, SPID 1015, PGA utilizada 3 761 708 bytes. [20261122T132743Z_09-sesion-pga.script.log](lab4/evidencia/script/20261122T132743Z_09-sesion-pga.script.log)

- **Diseño de auditoría temporal.** Crear una cuenta local en FREEPDB1 con CREATE USER auditor_clinica IDENTIFIED BY <secreto privado>, conceder CREATE SESSION y GRANT READ ANY TABLE ON SCHEMA admin_clinica TO auditor_clinica. Al finalizar la semana, ejecutar REVOKE READ ANY TABLE ON SCHEMA admin_clinica FROM auditor_clinica y bloquear la cuenta. El alcance incluye nuevas tablas de clínica. Es un diseño sin alta de usuario. [20261122T132747Z_10-que-ve-cada-usuario.script.log](lab4/evidencia/script/20261122T132747Z_10-que-ve-cada-usuario.script.log)

- **Plan de copia.** Los tamaños físicos de datafiles, control y online redo más 3584 bytes del SPFILE y 2048 del password file suman aproximadamente 4,51 GiB. Se excluyen temporales. RMAN protege datafiles, control file y SPFILE; gestiona archived redo por separado. Los online redo no se copian como tales y el password file necesita protección fuera de RMAN. [20261122T132801Z_11-archivos-so.script.log](lab4/evidencia/script/20261122T132801Z_11-archivos-so.script.log)

- **Segundo bloque.** Estudiante 19001, bloque 1204, slot 3: 85 filas y avsp 0x365 (869 bytes). Para 101 fueron 90 filas y 865 bytes. Ambas ITL conservan --U-, con Lck 85 y 90 respectivamente. [20261122T132802Z_12-bloque-extra.script.log](lab4/evidencia/script/20261122T132802Z_12-bloque-extra.script.log)

- **Dimensionamiento.** Se predijeron 248 bloques para 60 000 filas de 30 bytes con PCTFREE 10. DBA_TABLES mostró 370 bloques bajo la HWM. A 150 MiB/s, leer 370 × 8192 bytes requiere unos 19,3 ms de transferencia ideal, sin posicionamiento ni CPU. [20261122T132851Z_13-matriculas.script.log](lab4/evidencia/script/20261122T132851Z_13-matriculas.script.log)

- **Informe.** Los riesgos, las prioridades y las acciones concretas están en la [autopsia](lab4-autopsia.md). [20261122T132809Z_15-autopsia-instancia.spool.log](lab4/evidencia/spool/20261122T132809Z_15-autopsia-instancia.spool.log)

## Preguntas tipo examen

1. **A y D.** SHUTDOWN IMMEDIATE cierra los archivos de forma consistente. Una copia completa puede abrirse al restaurarla sin aplicar redo posterior.

2. **B.** Con el tablespace offline se copia el archivo, se registra el nombre nuevo y finalmente se vuelve a poner online.

3. **A y C.** STARTUP_TIME pertenece al arranque actual. CREATED y DBID describen la base persistente.

4. **A y C.** En NOMOUNT ya existen parámetros y estructuras de instancia. Es la etapa para crear el control file.

5. **B.** Para cambiar el modo de archivado la base tiene que estar montada y cerrada a los usuarios.

6. **B.** Con SPFILE y un parámetro dinámico, el ámbito predeterminado en la raíz es BOTH.

7. **C.** PROCESSES pertenece a la instancia. La PDB no admite ese cambio aunque se especifique SPFILE.

8. **A y C.** El PFILE conocido permite arrancar y reconstruir después el SPFILE persistente.

9. **B.** SGA_TARGET activa ASMM. DB_CACHE_SIZE explícito fija un mínimo para ese componente.

10. **A y D.** En servidor dedicado, la sesión y el área privada de ordenación usan PGA.

11. **C.** LGWR persiste el redo del commit antes de confirmar un commit síncrono.

12. **B y D.** PMON y SMON son procesos básicos de la instancia. El archivado y los trabajos dependen de configuración y carga.

13. **B.** Desde FREEPDB1 la vista de datafiles limita las filas al contenedor de la sesión.

14. **B.** CONTAINER_DATA controla qué contenedores puede observar el usuario común desde la raíz.

15. **A y D.** El privilegio abarca tablas presentes y futuras dentro del esquema indicado.

16. **B y D.** Los control files y los online redo logs forman parte del conjunto físico de la base.

17. **C.** En el supuesto sin archivado ni otra copia del disco perdido, el punto de retorno es el último respaldo completo.

18. **B.** El formato BIGFILE emplea los bits de dirección de otra manera. El segundo argumento selecciona esa interpretación.

19. **A y B.** PCTFREE reserva espacio para actualizaciones y limita la incorporación de nuevas filas al bloque.

20. **B.** floor((8192−96)×0,90/180)=40 filas por bloque. Dos millones de filas requieren 50 000 bloques.

21. **B.** Scattered read indica lectura multibloque hacia buffers de la caché.

22. **A y C.** LIST CHAINED ROWS identifica ROWID afectados. Reorganizar con margen reduce las migraciones por crecimiento.

23. **B.** Una fila de 12 000 bytes supera la capacidad de un bloque de 8 KiB y necesita varias piezas.

24. **B.** Una cuenta de observación y un permiso explícito sobre el alert log acotan el impacto de un error.

25. **B.** PDB$SEED es la plantilla de solo lectura.

26. **C.** En una PDB, el prefijo común C## es inválido para ese nombre local.

27. **B.** Primero se cierra la PDB abierta y después se ejecuta DROP con INCLUDING DATAFILES.

28. **A y C.** El control file contiene el inventario de datafiles y redo accesible en MOUNT.

29. **A.** X$KCCLE consulta estructuras del control file.

30. **B.** Las vistas CDB_ están definidas en la raíz y en las PDB, con visibilidad según el contenedor.

31. **B.** Los tempfiles son recreables y RMAN no respalda sus bloques como datafiles permanentes.

32. **B.** La instancia conserva sus parámetros en memoria y permite reconstruir el SPFILE.

33. **B.** V$PWFILE_USERS enumera las cuentas y privilegios administrativos del password file.

34. **A y B.** La ITL registra transacciones sobre el bloque y el directorio de filas ubica los slots.

35. **B.** AUTOALLOCATE comienza habitualmente con 64 KiB y aumenta el tamaño de las extensiones con el crecimiento.

36. **B.** ASSM localiza bloques con espacio mediante mapas de bits.

37. **B.** En la configuración por defecto del ejercicio moderno el tablespace es BIGFILE y localmente gestionado. El tipo por defecto puede configurarse.

38. **A.** Las cuatro lecturas lógicas se atendieron en la caché de buffers.

39. **A y B.** Reservar más espacio o aumentar el tamaño de la fila reduce las filas que caben por bloque.

40. **B.** Vaciar la caché afecta a todas las sesiones y aumenta temporalmente las lecturas físicas y la latencia.

41. **B.** Una fila migrada creció tras insertarse. Una fila encadenada ocupa varias piezas.

42. **A.** REBUILD reconstruye las referencias a los ROWID actuales. MOVE ONLINE puede mantener los índices utilizables.

43. **A.** V$DIAG_ALERT_EXT expone entradas del alert log mediante SQL.

44. **A y B.** Conviene examinar los segmentos responsables y ampliar la capacidad según el tipo de tablespace y el espacio disponible.

45. **A y B.** Las PDB comparten la instancia y los online redo logs.

46. **B.** Para el usuario local del supuesto se rechaza el cambio de contenedor por privilegios insuficientes.

