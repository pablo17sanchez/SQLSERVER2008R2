select  CASE n.mes_correspondiente
	WHEN 1 THEN 'Enero'
	WHEN 2 THEN 'Febrero'
	WHEN 3 THEN 'Marzo'
	WHEN 4 THEN 'Abril'
	WHEN 5 THEN 'Mayo'
	WHEN 6 THEN 'Junio'
	WHEN 7 THEN 'Julio'
	WHEN 8 THEN 'Agosto'
	WHEN 9 THEN 'Septiembre'
	WHEN 10 THEN 'Octubre'
	WHEN 11 THEN 'Noviembre'
	WHEN 12 THEN 'Diciembre'
End Mes_Correspondiente from vw_nomina n
group by Mes_Correspondiente 
