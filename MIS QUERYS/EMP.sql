

select Numero, Clasificacion, Grupo_Trabajo,Codigo_Titular, Nombre,Apellido1,Apellido2,Salario_Base,Salario_Hora,Fecha_Nacimiento,Estatus,
floor((((cast(datediff(day, Fecha_Nacimiento, GETDATE()) as float)/365-(floor(cast(datediff(day, Fecha_Nacimiento, GETDATE()) as float)/365)))*12)-floor((cast(datediff(day, Fecha_Nacimiento, GETDATE()) as float)/365-(floor(cast(datediff(day, Fecha_Nacimiento, GETDATE()) as float)/365)))*12))*(365/12)) 
 AS [Dias], floor((cast(datediff(day, Fecha_Nacimiento, GETDATE()) as float)/365-(floor(cast(datediff(day, Fecha_Nacimiento, GETDATE()) as float)/365)))*12) AS [Meses], floor(cast(datediff(day, Fecha_Nacimiento, GETDATE()) as float)/365) AS [Anos],
 GETDATE()  as fecha,Fecha_Ingreso,
 floor((((cast(datediff(day, Fecha_Ingreso, GETDATE()) as float)/365-(floor(cast(datediff(day, Fecha_Ingreso, GETDATE()) as float)/365)))*12)-floor((cast(datediff(day, Fecha_Ingreso, GETDATE()) as float)/365-(floor(cast(datediff(day, Fecha_Ingreso, GETDATE()) as float)/365)))*12))*(365/12)) 
 AS [Dias_Ingreso], floor((cast(datediff(day, Fecha_Ingreso, GETDATE()) as float)/365-(floor(cast(datediff(day, Fecha_Ingreso, GETDATE()) as float)/365)))*12) AS [Meses_Ingreso], floor(cast(datediff(day, Fecha_Ingreso, GETDATE()) as float)/365) AS [Anos_Ingreso],
 GETDATE()  as fecha,E_Mail
 from Personal_Nomina..Empleados
 where  floor(cast(datediff(day, Fecha_Nacimiento, GETDATE()) 
 as float)/365) >18 and Nombre like '%%'   order  by Salario_Base desc

select Grupo_Trabajo,COUNT(*) from Personal_Nomina..Empleados group by Grupo_Trabajo



select *



select * from Personal_Nomina..Accion_Personal where Razon_Accion LIKE 'REAJUSTE' order by Fecha desc


 
 
 



