

USE SITGPIntegration
DELETE TransaccionVentaItem WHERE DescripcionProducto='N'
DELETE TransaccionVenta WHERE [Status]='N'
DELETE CargaGP WHERE Estatus='S'

use SITGPIntegration
select * from TransaccionVentaItem WHERE DescripcionProducto='N'
select IDVendedor,* from TransaccionVenta WHERE [Status]='N'
select * from CargaGP WHERE Estatus='S'

SELECT *
FROM sys.dm_exec_query_stats AS deqs
CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest
ORDER BY deqs.last_execution_time DESC

select * from GPHN..RM00101  

select * from transaccionventa where Tipo=2


--update transaccionventa set Notas='CARGADO A PRUEBA' where Tipo=2
 
select MAX(IDVenta) from transaccionventa

select MAX(IDVenta) from TransaccionVentaItem


select * from TransaccionVentaItem WHERE IDVenta=1882861


select * from transaccionventa WHERE IDVenta=1923127

select * from TransaccionVentaItem where IDVenta=1923126


SELECT IDVenta,COUNT(*) AS CANTIDAD
 FROM TransaccionVentaItem GROUP BY IDVenta HAVING COUNT(*)>1 order by IDVenta desc
 
 
 
 
 
 
 
 
 
 select * fro
 
 
 



















select * from transaccionventa where NoDocumento in (select FACNUM from PalmComSync..IN_FACTURA)






























