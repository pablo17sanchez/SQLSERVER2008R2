DECLARE 
@Mes INT,
@Mes1 INT,
@Anio INT

SET @Mes = 1
SET @Mes1 = 11
SET @Anio = 2009

SELECT IE.Ano_Correspondiente,IE.Mes_Correspondiente,IE.Desc_Grupo,IE.Desc_SubGrupo,IE.codigo_empleado,IE.nom_emp,SUM(IE.valor)Valor FROM (
SELECT n.mes_correspondiente,n.ano_correspondiente,e.Desc_Grupo,e.Desc_SubGrupo,i.codigo_empleado,e.nom_emp,SUM(i.valor)Valor FROM vw_ingresos_nomina_empleados i join vw_nomina n 
ON i.codigo_nomina = n.codigo_nomina JOIN vw_empleados e ON i.codigo_empleado = e.numero
GROUP BY n.mes_correspondiente,n.ano_correspondiente,e.Desc_Grupo,e.Desc_SubGrupo,codigo_empleado,e.nom_emp
UNION ALL
SELECT n.mes_correspondiente,n.ano_correspondiente,e.Desc_Grupo,e.Desc_SubGrupo,ht.codigo_empleado,e.Nom_Emp,SUM(ht.valor)valor FROM vw_horas_trabajadas_nomina ht JOIN vw_nomina n 
ON ht.codigo_nomina = n.codigo_nomina JOIN vw_empleados e ON ht.codigo_empleado = e.numero
GROUP BY n.mes_correspondiente,n.ano_correspondiente,e.Desc_Grupo,e.Desc_SubGrupo,codigo_empleado,e.nom_emp)IE

WHERE IE.mes_correspondiente Between @Mes and @Mes1 and IE.ano_correspondiente = @Anio
GROUP BY IE.mes_correspondiente,IE.ano_correspondiente,IE.Desc_Grupo,IE.Desc_SubGrupo,IE.codigo_empleado,IE.nom_emp
ORDER BY IE.Desc_Grupo,IE.Desc_SubGrupo,IE.codigo_empleado



--select * from vw_empleados
