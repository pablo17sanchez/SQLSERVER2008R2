select idvendedor,nombrevend,codclie,a.facnum,convert(varchar,fechafac,103)fecha,monpago,montofac,ncf,cantidad,codprod,precio from palmcomsync..in_factura_temp a left join palmcomsync..in_detafac b 
on a.facnum = b.facnum join palmcomsync..out_config c on a.palmid = c.palmid
where a.facnum = 'F5808238'


use palmcomsync

insert into in_factura
select * from in_factura_temp
where facnum between 'F7205007' and 'F7205019'

select * from sitgpintegration..transaccionventa
where nodocumento between 'F5213262' and 'F5213284'

order by idventa

delete from sitgpintegration..transaccionventai
where idventa between '57892' and '57914'
 