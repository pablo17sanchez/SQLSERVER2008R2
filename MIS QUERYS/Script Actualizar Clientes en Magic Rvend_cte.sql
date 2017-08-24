Create Table #rvend_cte
(Cod_vend int null,
 Custnmbr varchar(10) null,
 Custname nvarchar(50) null
)

insert into #rvend_cte
(custnmbr,cod_vend)
select a.codigo,'3191'idvendedor from import..coordenadas a join palmcomsync..gp_ruta b 
on a.ruta= b.nombreruta
where ruta = 'sd300-11'

update #rvend_cte 
set custname = a.custname
from gphn..rm00101 a join #rvend_cte on 
a.custnmbr = #rvend_cte.custnmbr

insert into hndbasegp..rvend_cte
(cod_vend,custnmbr,custname)
select * from #rvend_cte

select * from hndbasegp..rvend_cte
where cod_vend = 3191

drop table #rvend_cte