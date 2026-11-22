# Lab 3 · Comprobación del entorno Oracle

## Docker

1. Una imagen contiene las capas y la configuración inicial con las que Docker crea un contenedor. El contenedor tiene su propia capa de escritura y un proceso principal. Se pueden ejecutar dos contenedores Alpine desde la misma imagen y crear archivos distintos en cada uno.
2. Al eliminar el primer contenedor se eliminó su capa de escritura y, con ella, la nota. En la segunda prueba la nota se escribió en un volumen con nombre. Al montar ese volumen en otro contenedor se pudo leer el mismo archivo.
3. `docker ps` lista los contenedores en ejecución. Con `-a` aparecen también los detenidos. `Exited (0)` indica que el proceso principal terminó con código de éxito.
4. En `-p 8181:8181` el primer puerto pertenece al equipo y el segundo al contenedor. Con `-p 80:8080`, el tráfico que llega al puerto 80 del equipo se dirige al 8080 del contenedor. El nginx del ejercicio escucha en el 80 interno, por lo que ese mapeo no llega a su servidor HTTP.
5. El proceso principal de hello-world imprime el mensaje y termina. La imagen de Oracle mantiene en ejecución los servicios de la base. El estado de salud permite saber cuándo admiten conexiones.
6. El digest identifica por contenido la imagen descargada. La etiqueta `latest` puede apuntar a otra versión en la próxima descarga. Registrar el digest permite comparar dos instalaciones.
7. La operación que elimina el almacenamiento persistente es borrar el volumen `oralab-26ai-data` después de desconectarlo de todos los contenedores. Eliminar únicamente el contenedor conserva ese volumen con nombre.

## Git y evidencias

8. El issue recoge los criterios de aceptación, la rama reúne el trabajo y el pull request permite revisar código y evidencias frente a esos criterios. En el mismo historial quedan las dependencias para los laboratorios siguientes.
9. `source` ejecuta el archivo en la shell actual. Así quedan disponibles las constantes y la función `ts`. Con `bash archivo` se definen en un proceso hijo y desaparecen al terminar.
10. `20260915T091230Z` indica el 15 de septiembre de 2026 a las 09:12:30 UTC. `02` identifica el paso, `docker` el contenido y `.script.log` la salida de terminal.
11. `.gitattributes` fija LF para Bash, SQL y Markdown. Evita que un retorno de carro de Windows pase a formar parte de un comando o del nombre del intérprete.
12. Un commit de merge conserva los commits por parte y el punto de integración de la rama. Esto permite localizar la evidencia y los cambios de cada etapa.

## Credenciales

13. Primero se excluye el archivo privado mediante `.gitignore`. Después se versiona una plantilla, se crea una copia local con los valores reales y se cargan esos valores al ejecutar los scripts. Si se omite la primera capa, un `git add` puede incorporar las credenciales al historial.
14. Una contraseña literal puede quedar en el historial, una captura o un listado de procesos. El script carga el archivo privado y Docker recibe la variable por nombre. Quien administra el motor sigue teniendo acceso privilegiado al contenedor.
15. Hay que rotar la credencial expuesta, revisar su uso y coordinar la limpieza del historial y de las copias afectadas. Borrar la línea en un commit posterior deja accesible el anterior.

## Oracle

16. SQL*Plus se ejecuta dentro del contenedor. Le enviamos el SQL del repositorio por entrada estándar con `docker exec -i`; la redirección y `tee` se ejecutan en Ubuntu. Así los archivos de entrada y de evidencia viven en el repositorio. SQLcl corre en Ubuntu y sí puede usar SPOOL directamente ahí.
17. `WHENEVER SQLERROR EXIT SQL.SQLCODE` detiene SQL*Plus y comunica el error al script. Sin esa regla puede seguir ejecutando sentencias y producir un log aparentemente completo. El DDL ya aplicado puede haber quedado confirmado y hay que comprobarlo antes de reintentar.
18. Una migración es un cambio numerado sobre el esquema. V000 crea usuarios y tablespaces y V001 depende de ellos para crear tablas. Editar una versión ya aplicada haría que dos bases con el mismo número de versión tuviesen estructuras distintas. Las correcciones se añaden en una migración posterior.
19. El servicio FREEPDB1 dirige la sesión a la base conectable que contiene los usuarios y las tablas del laboratorio. FREE corresponde al contenedor raíz. El SID identifica una instancia y no selecciona por sí solo esa PDB.
20. SQLcl aporta formatos de salida, historial y gestión de conexiones. SQL*Plus está disponible dentro de la imagen y sirve para ejecutar los scripts mediante la entrada estándar. Manejar ambos permite operar tanto desde el cliente de trabajo como desde el propio contenedor.

## Ubuntu y WSL

21. WSL 2 aporta un kernel Linux, el gestor de paquetes apt y herramientas como tmux y ss. En Git Bash pueden intervenir la conversión automática de rutas de Windows al llamar a Docker y diferencias de permisos o pseudoterminal en sesiones interactivas.
22. Trabajar en el sistema de archivos Linux conserva permisos, enlaces y bits de ejecución, y reduce el coste de Git al recorrer muchos archivos. Los scripts usan Bash porque el guion y sus construcciones están escritos para ese intérprete. La shell interactiva se puede elegir independientemente del shebang.

