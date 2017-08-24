use palmcomsync

insert into palmcomsync..in_factura
select * from in_factura_temp a
where facnum between 'F3110911' and 'F3110924'

insert into palmcomsync..in_factura
select * from in_factura_temp a
where not exists (select * from palmcomsync..in_factura b
where a.facnum = b.facnum)

select * from 
update out_config
set palmid = 
where idvendedor = 2985

select * from out_config
where inifac = 31

