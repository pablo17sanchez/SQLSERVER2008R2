select * from gphn..rm00102


update rm00102
set userdef1=a.latitud,userdef2 = a.longitud
from import..coordenadas a left join rm00102
on a.codigo = rm00102.custnmbr
where rm00102.custnmbr between '0' and '9999' 

select * from import..coordenadas