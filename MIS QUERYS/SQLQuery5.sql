select em.numero,em.desc_clasificacion,em.desc_grupo,em.desc_subgrupo,sum(em.salario_base),sum(co.valor) [ValorComision],co.ano_correspondiente,co.mes_correspondiente from vw_empleados em right join
(select c.numero,a.codigo_nomina,c.desc_clasificacion,c.desc_grupo,c.desc_subgrupo,b.valor,d.descripcion,a.ano_correspondiente,a.mes_correspondiente from nomina_general a join ingresos_nomina_Empleados b
on  a.codigo_nomina = b.codigo_nomina join vw_empleados c on b.codigo_empleado = c.numero join tipo_ingresos d on b.tipo_ingreso = d.codigo
where b.tipo_ingreso in('50','26')) co on em.numero = co.numero
group by em.numero,em.desc_clasificacion,em.desc_grupo,em.desc_subgrupo,co.ano_correspondiente,co.mes_correspondiente

/*
select  codigo_nomina,codigo_empleado,b.descripcion,sum(valor) from dbo.Ingresos_Nomina_Empleados a join tipo_ingresos b on a.tipo_ingreso = b.codigo
group by codigo_nomina,codigo_empleado,b.descripcion
order by codigo_nomina,codigo_empleado

select * from dbo.Ingresos_Nomina_Empleados 
*/