/*
create table Prueba_V1
(codigo nvarchar(4)primary key,
nombre nvarchar(100)not null,
apellido nvarchar(100) not null,
edad int not null,
departamento nvarchar(60) not null)
*/
create procedure almacenar_empleados @codigo nvarchar(4),
@nombre nvarchar(100), @apellido nvarchar(100), @edad int, 
@departamento nvarchar(60)
as
begin
insert into Prueba_V1
values(@codigo,@nombre,@apellido,@edad,@departamento)
end