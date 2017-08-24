
delete from descuentos
where fecha = '2009.03.30'


select * from personal_nomina_temp..descuentos
where fecha = '2009.03.30' and codigo_tipo_descuento not in (4,47,49,48,52,51,50)
order by codigo_tipo_descuento

select sum(valor) from import..descuentos_nomina_empleados_300309
where tipo_descuento = '4' and valor = '3680'

select * from nomina_ingdesccomp