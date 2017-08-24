SELECT     
CASE mes_nomina WHEN '1' THEN 'Enero' 
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
									WHEN '2' THEN 'Segundo Periodo' END AS [Período Nomina], 
b.Codigo_Nomina, b.Tipo_Nomina, b.Ano_Nomina, b.Mes_Nomina, b.Periodo_Nomina, ht.Codigo_empleado, ht.Tipo_Hora, ht.Cantidad, ht.Valor, a.Descripcion, 
                      c.Descripcion AS Expr1
FROM         dbo.Grupos_Empleados AS c INNER JOIN
                      dbo.Empleados_Procesados_Nomina AS b ON c.Codigo = b.Grupo_Emp INNER JOIN
                      dbo.SubGrupos_Empleados AS a ON b.SubGrupo_Emp = a.Codigo INNER JOIN
                      dbo.Horas_Trabajadas_Nomina AS ht ON b.Codigo_Empleado = ht.Codigo_empleado AND b.Codigo_Nomina = ht.Codigo_nomina
GROUP BY b.Mes_Nomina, b.Periodo_Nomina, b.Codigo_Nomina, b.Tipo_Nomina, b.Ano_Nomina, ht.Codigo_empleado, ht.Tipo_Hora, ht.Cantidad, ht.Valor, 
                      a.Descripcion, c.Descripcion