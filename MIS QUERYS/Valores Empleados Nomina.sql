select *from dbo.vw_CuentasMovimientos
where ano_nomina =2009 and mes_nomina=5 and periodo_nomina=2

select * from empleados_procesados_nomina

select 'ing',a.tipo_ingreso,b.descripcion,a.valor from ingresos_nomina_empleados a join tipo_ingresos b 
on a.tipo_ingreso = b.codigo 
where codigo_nomina = '119' 
union all
select 'desc',a.tipo_descuento,b.descripcion,a.valor from descuentos_nomina_empleados a join tipo_ingresos b 
on a.tipo_descuento = b.codigo where codigo_nomina = '119' 

select 'ing',codigo_empleado,tipo_ingreso,descripcion,sum(valor)[valor]from ingresos_nomina_empleados a join tipo_ingresos b
on a.tipo_ingreso = b.codigo 
where codigo_nomina = '119'
group by codigo_empleado,tipo_ingreso,descripcion
union all
select 'desc',codigo_empleado,tipo_descuento,descripcion,sum(valor)[valor] from descuentos_nomina_empleados a join tipo_descuentos b
on a.tipo_descuento = b.codigo 
where codigo_nomina = '119'
group by codigo_empleado,tipo_descuento,descripcion
