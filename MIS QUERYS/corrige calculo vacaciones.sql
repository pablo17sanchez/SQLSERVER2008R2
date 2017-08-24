USE PERSONAL_NOMINA

update vacaciones_pago

set valor_avance = vacaciones.valor_avance

from vacaciones, vacaciones_pago

where vacaciones_pago.cod_vacaciones = vacaciones.codigo
go

--para chequear,
 

select a.codigo, a.valor_avance, b.cod_vacaciones, b.valor_avance

from vacaciones a, vacaciones_pago b

where b.cod_vacaciones = a.codigo

