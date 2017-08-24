select Numero, Nombre, (Apellido1 + ' '+ Apellido2), cedula, Cod_Supervisor  from empleados
where numero = '5103'



insert into TWO..UPR00100 (employid,LASTNAME,FRSTNAME,SOCSCNUM,SUPERVISORCODE_I )
SELECT Numero, (Apellido1 + ' '+ Apellido2),Nombre, cedula,Cod_Supervisor  FROM NOMINA..Empleados 
where numero = '5103'

SELECT * FROM UPR00100


