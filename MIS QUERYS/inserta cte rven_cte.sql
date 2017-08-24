use hndbasegp
select cod_vend,custnmbr,custname from 

truncate table rvend_cte

insert into hndbasegp..rvend_cte
(custnmbr,custname,cod_vend)
select codcliente,nombre,b.idvendedor from palmcomsync..gp_clientediasruta a join palmcomsync..gp_ruta b on a.codruta = b.codruta
where not exists(select rtrim(custnmbr)+' '+cod_vend from hndbasegp..rvend_cte where rtrim(custnmbr)+' '+cod_vend = rtrim(codcliente)+' '+b.idvendedor)
order by idvendedor




select * from hndbasegp..rvend_cte
where  not exists(select rtrim(codcliente)+' '+b.idvendedor from palmcomsync..gp_clientediasruta a join palmcomsync..gp_ruta b on a.codruta = b.codruta where rtrim(custnmbr)+' '+cod_vend = rtrim(codcliente)+' '+b.idvendedor)

