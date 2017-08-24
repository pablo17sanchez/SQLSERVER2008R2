
update two..rm00301
set inactive =1
where exists (select numero,estatus from empleados 
where empleados.numero = two..rm00301.slprsnid and estatus in('c','i') and two..rm00301.slprsnid between '0' and '999999' )

select * from two..rm00301
order by slprsnid

update personal_nominatemp..empleados
set estatus = 'A'
where numero = 1372