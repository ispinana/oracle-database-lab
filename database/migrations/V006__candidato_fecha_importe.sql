-- Experimento Q11. Evaluar ahorro en el informe anual y coste por alta.
WHENEVER SQLERROR EXIT FAILURE
ALTER SESSION SET CONTAINER=FREEPDB1;
CREATE INDEX tiendasur.ix_exp_fecha_importe ON tiendasur.pedido(fecha_pedido, importe) ONLINE;
