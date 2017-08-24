SELECT     CASE mes_nomina 
WHEN '1' THEN 'Enero' 
WHEN '2' THEN 'Febrero' 
WHEN '3' THEN 'Marzo' 
WHEN '4' THEN 'Abril' 
WHEN '5' THEN 'Mayo' 
WHEN '6' THEN 'Junio' 
WHEN '7' THEN 'Julio' 
WHEN '8' THEN 'Agosto' 
WHEN '9' THEN 'Septiembre' 
WHEN '10' THEN 'Octubre' 
WHEN '11' THEN 'Noviembre' 
WHEN '12' THEN 'Diciembre' END AS [Mes Nomina],
CASE periodo_nomina WHEN '1' THEN 'Primer Periodo' 
					WHEN '2' THEN 'Segundo Periodo' END AS [Período Nomina], b.Ano_Nomina,ht.Codigo_empleado, dbo.vw_Empleados.Nombre, dbo.vw_Empleados.Apellidos, dbo.Tipo_Horas.Descripcion AS [Tipo Hora], ht.Cantidad, ht.Valor, c.Descripcion AS Grupo, a.Descripcion AS SubGrupo
FROM dbo.Grupos_Empleados AS c INNER JOIN
( select codigo_nomina,ano_nomina,mes_nomina,periodo_nomina,codigo_empleado,grupo_emp,subgrupo_emp,sal_base from dbo.Empleados_Procesados_Nomina
union all
 select codigo_nomina,ano_nomina,mes_nomina,periodo_nomina,codigo_empleado,grupo_emp,subgrupo_emp,sal_base from dbo.Empleados_Procesados_Nomina_temp)AS b ON c.Codigo = b.Grupo_Emp INNER JOIN dbo.SubGrupos_Empleados AS a ON b.SubGrupo_Emp = a.Codigo INNER JOIN 
(select tipo_hora,codigo_nomina,codigo_empleado,cantidad,valor from horas_trabajadas_nomina
union all
select tipo_hora,codigo_nomina,codigo_empleado,cantidad,valor from horas_trabajadas_nomina_temp) AS ht ON b.Codigo_Empleado = ht.Codigo_empleado AND  b.Codigo_Nomina = ht.Codigo_nomina INNER JOIN dbo.Tipo_Horas ON ht.Tipo_Hora = dbo.Tipo_Horas.Codigo INNER JOIN dbo.vw_Empleados ON b.Codigo_Empleado = dbo.vw_Empleados.Numero
WHERE ano_nomina = 2009 and mes_nomina = 08 and periodo_nomina = 02

GROUP BY b.Ano_Nomina, ht.Codigo_empleado, ht.Cantidad, ht.Valor, a.Descripcion, c.Descripcion, b.Mes_Nomina, b.Periodo_Nomina,dbo.Tipo_Horas.Descripcion, dbo.vw_Empleados.Nombre, dbo.vw_Empleados.Apellidos