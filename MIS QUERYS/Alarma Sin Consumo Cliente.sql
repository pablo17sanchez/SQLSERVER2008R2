select codcliente,NombCliente,UlFechaFact,NombreRuta,(select COUNT(*) from palmcomsync..gp_clientediasruta a where a.nombreruta = CP.nombreruta) CantCliente,IdVendedor,NombreVendedor,nombreSubZona,(select COUNT(*) from palmcomsync..vw_gp_clientediasrutazona a where a.nombreSubZona = Cp.nombreSubZona) CantCTESup,nombreSupervisor,IdZona,(select COUNT(*) from palmcomsync..vw_gp_clientediasrutazona a where a.idzona = Cp.idzona) CantCTECoord, ZonaResp from vw_clientesgp c join palmcomsync..vw_clientes_ruta_palm cp on c.codcliente = cp.custnmbr 

group by codcliente,NombCliente,UlFechaFact,NombreRuta,IdVendedor,NombreVendedor,nombreSubZona,nombreSupervisor,IdZona,ZonaResp 
having UlFechaFact <GETDATE()-8
order by codcliente,UlFechaFact

select count(nombreruta) from vw_ventasgp sop join palmcomsync..vw_rutazona rv
on sop.slprsnid = rv.idvendedor
where docdate < GETDATE()-8 and nombreruta = 'sd100-01'
--group by nombreruta,custnmbr

(select nombreSubZona,custnmbr from vw_ventasgp sop join palmcomsync..vw_rutazona rv
on sop.slprsnid = rv.idvendedor
where docdate < GETDATE()-8 and nombreSubZona = 'zsd-01'
group by nombreSubZona,custnmbr)

