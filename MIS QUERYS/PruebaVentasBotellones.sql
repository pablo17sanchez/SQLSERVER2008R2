use gphn 

select NombreRuta,IdVendedor,NombreVendedor,NZonaSup,NombreSupervisor,IdZona,ZonaDesc,ZonaResponsable,codcliente,NombCliente,(select sum(quantity) from vw_ventasgp where custnmbr = c.codcliente and NombreRuta = c.NombreRuta and itemnmbr like 'pt3%' and docdate between DateAdd(day,-33,getdate()) and getdate()-3
having sum(quantity) <70) from vw_ruta_clientes c


