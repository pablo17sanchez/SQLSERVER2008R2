
SELECT rtrim(mae.numero)[Id vendedor],upper(mae.nombre)[Nombre],upper(mae.apellidos)[Apellidos],upper(mae.direccion)[Direccion],case mae.estatus
		when 'A' then 'ACTIVO' end[Estatus],
convert(nvarchar(50),mae.nombre_cargo)[Cargo],upper(mae.sucursal)[Sucursal],mae.telefono1
FROM personal_nominatemp..subGRUPOS_EMPLEADOS SUB join personal_nominatemp..vw_empleados mae
on sub.codigo = mae.subgrupo_trabajo
where descripcion in (select descripcion from personal_nominatemp..subGRUPOS_EMPLEADOS
						where descripcion like '%hielo%'and descripcion like '%distribucion%' and								desc_posicion like '%chofer%'
						union 
					 select descripcion from personal_nominatemp..subGRUPOS_EMPLEADOS
						where descripcion like '%distribucion%'and	desc_posicion like '%ayudante%')
and not exists (select * from two..rm00301 v where mae.numero = v.slprsnid
				and  v.slprsnid between '0' and '9999999') and mae.estatus = 'A'
