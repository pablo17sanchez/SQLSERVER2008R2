use palmcomsync 

select * from gp_clientediasruta
where nombreruta = 'sd300-04'

Insert into gp_clientediasruta
(codcliente,nombre,codruta,nombreruta,Lunes,Martes,Miercoles,Jueves,Viernes,Sabado,Domingo)
select codigo,custname,codruta,ruta,'0','0','0','0','0','0','0' from import..coordenadas a join gphn..rm00101 b on a.codigo = b.custnmbr join gp_ruta c on a.ruta=c.nombreruta
--where ruta = 'sd300-04'
