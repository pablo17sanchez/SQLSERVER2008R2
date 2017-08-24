insert into hndbasegp..rvend_cte
(cod_vend,custnmbr)
select '3191'cod_vend,codigo from import..coordenadas 
where ruta = 'sd300-11'

select * from import..coordenadas