 
---Semanalmente deben realizar este procedimiento para evitar que la tabla de lotes se siga llenando tanto y evitar menos problemas con las contabilizaciones y confusión al usuario.
 
---1.       Herramienta – Utilidades – Ventas – Conciliar: Seleccionar la opcion Información de Lote.
---2.       Desde la venta de Query de SQL Server en la base de datos GPHN:
 
delete from sy00500
where numoftrx=0 and
bchsourc like 'RM%'
and bchsttus=0
 
---3.       Desde Dynamics GP seleccionar Herramienta – Utilidades – Financiero – Conciliar: Seleccionar la opcion Lotes.
---4.       Desde la ventana de Query de SQL Server en la base de datos GPHN:
 
delete from sy00500
where numoftrx=0 and
bchsourc like 'GL_Normal'
and bchsttus=0
 
---5.       Desde Dynamics GP seleccionar Archivo – Mantenimiento – Comprobar Vinculos: 
---a.      Seleccionar Serie: Compras.
---b.      Incluir en la lista Archivo logico de transaccion de cuentas por pagar
---6.       Desde la ventana de Query de SQL Server en la base de datos GPHN:
 
delete from sy00500
where numoftrx=0 and
bchsourc like '%PM_%'
and bchsttus=0
 
---7.       Desde Dynamics GP seleccionar Archivo – Mantenimiento – Comprobar Vinculos: 
---a.      Seleccionar Serie: Compras.
---b.      Incluir en la lista Transacciones de Compras
---8.       Desde la ventana de Query de SQL Server en la base de datos GPHN:
 
delete from sy00500
where numoftrx=0 and
(bchsourc like 'Rcvg Trx%' or bchsourc like 'Ret Trx%')
and bchsttus=0
 
---9.       Desde Dynamics GP seleccionar Archivo – Mantenimiento – Comprobar Vinculos: 
---a.      Seleccionar Serie: Inventario.
---b.      Incluir en la lista Trabajo de Transacciones de Inventario
---10.   Desde la ventana de Query de SQL Server en la base de datos GPHN:
 
delete from sy00500
where numoftrx=0 and
bchsourc like 'IV_%'
and bchsttus=0
 
---11.   Desde Dynamics GP seleccionar Archivo – Mantenimiento – Comprobar Vinculos: 
---a.      Seleccionar Serie: Ventas.
---b.      Incluir en la lista Trabajo de Ventas
---12.   Desde la ventana de Query de SQL Server en la base de datos GPHN:
 
delete from sy00500
where numoftrx=0 and
bchsourc like 'Sales_%'
and bchsttus=0
