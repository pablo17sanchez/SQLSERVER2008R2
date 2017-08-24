/*
delete from in_detafac 
where NOT EXISTS (select * from IN_FACTURA 
where in_factura.FACNUM = in_detafac.FACNUM)

*/


select * from IN_FACTURA
select FACNUM from IN_DETAFAC 
group by FACNUM