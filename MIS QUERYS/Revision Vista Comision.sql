select *--distinct NombreRuta, IdVendedor,nombrevendedor 
from PalmComSync..vw_gp_ClienteDiasRutaZona

select * 
from [View_VentasGP2] s
where YEAR(docdate)=2012 and MONTH(docdate)=1
and exists (
select CodCliente, IdVendedor, COUNT(*)
from palmcomsync..vw_gp_ClienteDiasRutaZona p
where p.IdVendedor = s.IdVendedor and p.CodCliente = s.CUSTNMBR
group by CodCliente, IdVendedor
having COUNT(*)>1)
order by SOPNUMBE, itemnmbr

select *
from PalmComSync..vw_gp_ClienteDiasRutaZona 
where CodCliente ='21119'	and idvendedor='2859'