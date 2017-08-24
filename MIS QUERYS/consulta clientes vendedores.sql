select * from OUT_CLIENTES
--order by NONCF
where CODCLIE = '26804'

select * from OUT_CONFIG
where IDVENDEDOR = '3907' 

select * from dbo.GP_CLIENTEDIASRUTA
where CodCliente = '26804'

select * from dbo.GP_RUTA
where NombreRuta = 'sd300-02'

select * from dbo.GP_CLIENTEDIASRUTA
where NombreRuta = 'SD300-02'

select a.PALMID, a.codclie,a.NOMBRE,a.DIRECCIONC,a.SECTOR,a.CIUDAD,a.CEDULA,a.TELEFONO1,a.TELEFONO2,b.NombreRuta ,a.TIPONCF  from OUT_CLIENTES a join dbo.GP_CLIENTEDIASRUTA b
on a.CODCLIE = b.CodCliente 
where b.NombreRuta = 'sd103-01' or b.NombreRuta = 'sd300-02' or b.NombreRuta = 'sd300-04' or b.NombreRuta = 'sd100-01'


SELECT * FROM OUT_CONFIG 
WHERE IDVENDEDOR  = '1650' 

/*

select * from IN_FACTURA
where FECHAFAC < '2012.06.01' --idvendedor = '4159'
order by HORA
*/

/*
select * from IN_DETAFAC
where FACNUM between  'F0911360'and 'F0911362'
order by descofe
*/
