USE [Personal_Nominatemp]
GO
/****** Object:  Trigger [dbo].[Tg_Insert_Vend_GP]    Script Date: 06/23/2009 13:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Richard Sanchez 
-- Create date: Junio 23 11:18 a.m. 
-- Description:	Inserta Vendedores/Ayudantes en la tarjeta de mantenimiento de Vendedores GP
-- =============================================
ALTER TRIGGER [dbo].[Tg_Insert_Vend_GP]
   ON  [dbo].[Empleados]
   AFTER INSERT 
AS 
BEGIN

	SET NOCOUNT ON;

INSERT INTO gphn..RM00301
(SLPRSNID,SLPRSNFN,SPRSNSLN,ADDRESS1,ADDRESS2,ADDRESS3,CITY,PHONE1)
SELECT rtrim(mae.numero)[Id vendedor],upper(mae.nombre)[Nombre],upper(mae.apellidos)[Apellidos],upper(mae.direccion)[Direccion],case mae.estatus
		when 'A' then 'ACTIVO' end[Estatus],
convert(nvarchar(50),mae.nombre_cargo)[Cargo],upper(mae.sucursal)[Sucursal],mae.telefono1
FROM personal_nomina..subGRUPOS_EMPLEADOS SUB join personal_nomina..vw_empleados mae
on sub.codigo = mae.subgrupo_trabajo
where descripcion in (SELECT descripcion FROM personal_nomina..subGRUPOS_EMPLEADOS
						where descripcion like '%hielo%'and descripcion like '%distribucion%' and								mae.desc_posicion like '%chofer%'
						union 
					 select descripcion from personal_nomina..subGRUPOS_EMPLEADOS
						where descripcion like '%distribucion%'and	mae.desc_posicion like '%ayudante%')
and not exists (select * from GPHN..rm00301 v where mae.numero = v.slprsnid
				and  v.slprsnid between '0' and '9999999') and mae.estatus = 'A'
END


