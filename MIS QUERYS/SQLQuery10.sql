Select NombreRuta,IdVendedor,NombreVendedor,nombreSubZona,nombreSupervisor,IdZona,ZonaResp,custnmbr,custname,sum(quantity)Cantidad from vw_ventasgp 
where itemnmbr like 'pt1%' and docdate between DateAdd(day,-33,getdate()) and getdate()-3
group by NombreRuta,IdVendedor,NombreVendedor,nombreSubZona,nombreSupervisor,IdZona,ZonaResp,custnmbr,custname
having sum(quantity) <150
order by cantidad