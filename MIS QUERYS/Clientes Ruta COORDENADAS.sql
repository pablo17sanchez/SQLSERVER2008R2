use hndbasegp
select *  from rvend_cte
where cod_vend = 3005

select * from palmcomsync..gp_clientediasruta
where nombreruta = 'sd300-04'

insert into hndbasegp..rvend_cte
(cod_vend,custnmbr,custname)
select '3005',codigo,custname from import..coordenadas a join gphn..rm00101 b on a.codigo = b.custnmbr 
join palmcomsync..gp_ruta c on a.ruta = c.nombreruta
where ruta = 'sd300-01'

select * from gphn..vw_clientes_CSR


