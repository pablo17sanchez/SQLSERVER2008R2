select convert(nvarchar(10),max(docdate),101)[FechaUltCompra],v.cod_vend[IdVendedor],c.nombrevend[NombreVendedor],p.custnmbr[IdCliente],v.custname[NombreCliente],rtrim(p.address1)[Direccion 1],rtrim(p.address2)[Sector],rtrim(p.address3)[Ciudad], case hold when 0 then 'SinSuspencion' when 1 then 'Suspendido' end [Estatus],(substring(phone1,1,3)+'-'+substring(phone1,4,7))[Telefono],p.salsterr from hndbasegp..rvend_cte v  join palmcomsync..out_config c on v.cod_vend = c.idvendedor join (select  r.custnmbr, r1.custname,r1.address1,r1.address2,r1.address3,hold, max(docdate) docdate,r1.phone1,r1.salsterr
from gphn..sop30200 r with (nolock) join gphn..rm00101 r1 with (nolock) on (r.custnmbr=r1.custnmbr)
where soptype = 3 
group by r.custnmbr, r1.custname,r1.address1,r1.address2,r1.address3,hold,r1.phone1,r1.salsterr
union all
select s.custnmbr, r.custname,r.address1,r.address2,r.address3,hold, max(docdate) docdate,r.phone1,r.salsterr
from gphn..sop10100 s with (nolock) join gphn..rm00101 r with (nolock) on (s.custnmbr=r.custnmbr)
where soptype=3 
group by s.custnmbr, r.custname,r.address1,r.address2,r.address3,hold,r.phone1,r.salsterr
)  p on v.custnmbr = p.custnmbr
where year(docdate) >'2005' and cod_vend = '1025'
group by docdate,v.cod_vend,c.nombrevend,p.custnmbr,v.custname,rtrim(p.address1),rtrim(p.address2),rtrim(p.address3), hold,p.phone1,p.salsterr 