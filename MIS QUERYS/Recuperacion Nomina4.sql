select codigo_empleado,sum (valor) from dbo.Comision_descuentos_300309 a
group by codigo_empleado

select codigo_empleado,valor from dbo.Comision_ingresos_nomina_empleados_300309


select codigo_empleado,sum(valor) from dbo.Comision_descuentos_300309
where codigo_empleado in ('2305','2690')
group by codigo_empleado

update ingresos_importar
set fec_labor = '2009.03.30'
where fec_labor is null

delete from ingresos_importar
