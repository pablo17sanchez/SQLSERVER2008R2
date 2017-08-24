select *  from descuentos
where fecha = '2009.03.30' and codigo_tipo_descuento in (4,47,49,48,52,51,50)
order by codigo_tipo_descuento

--delete from descuentos 
where fecha = '2009.03.30' and codigo_tipo_descuento in (4,47,49,48,52,51,50)
order by codigo_tipo_descuento

--delete from descuentos_nomina_empleados_temp
where codigo_nomina = '113' and tipo_descuento in (4,47,49,48,52,51,50)

--delete from empleados_procesados_nomina_temp
where codigo_nomina = '113'

select * from horas_trabajadas_nomina_temp
where codigo_nomina ='113'

delete from ingresos_nomina_empleados_temp
where codigo_nomina ='113' and tipo_ingreso = 50







