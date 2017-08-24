use gphn 

DECLARE 
@iFecha Datetime,
@aFecha Datetime

SET @iFecha = '2009.12.01'
SET @aFecha = '2009.12.12'

select Year(DocDate) Anio,month(DocDate)Mes,LocnCode Localidad,custnmbr CodCliente,custname Nombre,itemnmbr CodProd,itemdesc CodDesc,(quantity)Cantidad,(docamnt) Monto ,nombreruta,idvendedor,nombrevendedor,nombresubzona,nombresupervisor,idzona,zonaresp from vw_ventasgp
where docdate between @iFecha and @aFecha
group by DocDate,LocnCode,custnmbr,custname,itemnmbr,itemdesc,nombreruta,idvendedor,nombrevendedor,nombresubzona,nombresupervisor,idzona,zonaresp,quantity,docamnt

--select * from vw_ventasgp