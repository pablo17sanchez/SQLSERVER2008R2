select ng.mes_correspondiente,ng.ano_correspondiente,co.numero,co.SalarioBase,sum(co.valorcomision)[ValorComision],co.desc_clasificacion,co.desc_grupo,co.desc_subgrupo  from nomina_general ng join(
select b.codigo_nomina,em.numero,sum(em.salario_base)[SalarioBase],''[ValorComision],em.desc_clasificacion,em.desc_grupo,em.desc_subgrupo from vw_empleados em join ingresos_nomina_empleados b on em.numero = b.codigo_empleado
where tipo_ingreso = '1'
group by b.codigo_nomina,em.numero,em.desc_clasificacion,em.desc_grupo,em.desc_subgrupo 
union 
select codigo_nomina,codigo_empleado,'',sum(valor)[ValorComision],em1.desc_clasificacion,em1.desc_grupo,em1.desc_subgrupo from ingresos_nomina_empleados ine join vw_empleados em1 on ine.codigo_empleado = em1.numero
where tipo_ingreso in ('50','26')
group by codigo_nomina,codigo_empleado,em1.desc_clasificacion,em1.desc_grupo,em1.desc_subgrupo) co on ng.codigo_nomina = co.codigo_nomina
where ng.ano_correspondiente = '2008' and mes_correspondiente = '6' or ng.ano_correspondiente = '2009' and mes_correspondiente = '6' 
group by ng.mes_correspondiente,ng.ano_correspondiente,co.numero,co.desc_clasificacion,co.desc_grupo,co.desc_subgrupo,co.salariobase
order by numero