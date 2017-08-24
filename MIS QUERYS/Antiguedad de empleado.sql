SELECT *  FROM DataRS..GA_PARAMETROSMONTO
WHERE PROD<>'PT100'


SELECT * FROM PalmComSync..OUT_CLIENTES
WHERE PALMID LIKE 'GEA%'

SELECT * FROM Personal_Nomina..vw_Empleados


SELECT Numero,Nom_Emp,
       Fecha_Ingreso,
       Fecha_Estatus,
       Estatus,
        FLOOR(CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365) AS años,
        FLOOR((CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365 - FLOOR(CAST(DATEDIFF(day, Fecha_Ingreso, 
GETDATE()) AS float) / 365)) * 12) AS meses,
       FLOOR(((CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365 - FLOOR(CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365)) 
* 12 - FLOOR((CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365 - FLOOR(CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365)) 
* 12)) * (365 / 12)) AS dias,
TiempoEmp
       FROM Personal_Nomina..vw_Empleados
ORDER BY Numero


SELECT FLOOR(((CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365 - FLOOR(CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365)) 
* 12 - FLOOR((CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365 - FLOOR(CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365)) 
* 12)) * (365 / 12)) AS dias, 
FLOOR((CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365 - FLOOR(CAST(DATEDIFF(day, Fecha_Ingreso, 
GETDATE()) AS float) / 365)) * 12) AS meses, FLOOR(CAST(DATEDIFF(day, Fecha_Ingreso, GETDATE()) AS float) / 365) AS años
FROM Personal_Nomina..vw_Empleados