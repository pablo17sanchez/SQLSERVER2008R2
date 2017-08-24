select sum(valor) from descuentos_nomina_empleados
where codigo_nomina = '113'
go

select sum(valor) from descuentos_nomina_empleados
where codigo_nomina = '113' and tipo_descuento in (4,47,49,48,52,51,50)
order by tipo_descuento
go


select * from personal_nomina_temp..descuentos_nomina_empleados_temp
where codigo_nomina = '113' and tipo_descuento in (4,47,49,48,52,51,50)

select * from personal_nomina..descuentos_nomina_empleados
where codigo_nomina = '113'
order by tipo_descuento

select * 
from personal_nomina_temp..ingresos_nomina_empleados_temp b
where codigo_nomina = '113' and  exists   (select * from ingresos_nomina_empleados a
		      where b.codigo_nomina = a.codigo_nomina)
order by codigo_empleado

select * into import..desc_cancelados_300309 
from personal_nomina..descuentos
where codigo_tipo_descuento in (4,47,49,48,52,51,50)

