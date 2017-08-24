select ng.mes_correspondiente,ng.ano_correspondiente,em.numero,(select salario_base from empleados where numero = em.numero)[SalarioBase],(select sum(valor) from ingresos_nomina_empleados c where tipo_ingreso in ('50','26') and c.codigo_empleado = em.numero )[ValorComision],em.desc_clasificacion,em.desc_grupo,em.desc_subgrupo from vw_empleados em join ingresos_nomina_empleados b on em.numero = b.codigo_empleado join nomina_general ng on b.codigo_nomina = ng.codigo_nomina
where tipo_ingreso = '1' and ng.ano_correspondiente = '2008' and mes_correspondiente = '6' or ng.ano_correspondiente = '2009' and mes_correspondiente = '6' 
group by ng.mes_correspondiente,ng.ano_correspondiente,em.numero,em.desc_clasificacion,em.desc_grupo,em.desc_subgrupo

