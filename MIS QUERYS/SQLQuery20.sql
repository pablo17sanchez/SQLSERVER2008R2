select docdate,sum(quantity)Semana from vw_ventasgp
where docdate between dateadd(WEEK,-2,GETDATE()) and dateadd(WEEK,-1,GETDATE())
group by docdate
order by docdate

select idzona,ZonaResp,NombreSubZona,NombreSupervisor,nombreruta,IdVendedor,NombreVendedor,custnmbr,itemnmbr,itemdesc,dbo.fn_vtaSem1(custnmbr)UltimaSemana,sum(quantity)SemanaActual from vw_ventasgp sop1
where docdate between dateadd(WEEK,-1,GETDATE()) and dateadd(WEEK,0,GETDATE())
group by idzona,ZonaResp,NombreSubZona,NombreSupervisor,nombreruta,IdVendedor,NombreVendedor,custnmbr,itemnmbr,itemdesc
order by custnmbr

select codcliente,(select avg(quantity) from vw_ventasgp sp1
where docdate between dateadd(WEEK,-1,GETDATE()) and dateadd(WEEK,0,GETDATE()) and sp1.custnmbr=c.codcliente ),(select avg(quantity) from vw_ventasgp sp2
where docdate between dateadd(WEEK,-2,GETDATE()) and dateadd(WEEK,-1,GETDATE()) and sp2.custnmbr=c.codcliente) from vw_clientes_CSR C
where codcliente between '0' and '9999999'

select * from vw_ventasgp