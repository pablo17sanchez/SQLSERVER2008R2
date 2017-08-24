select a.fechafac,a.facnum,codclie,monpago,montofac,ncf,cantidad,precio,a.palmid from palmcomsync..in_factura a join palmcomsync..in_detafac b 
on a.facnum = b.facnum 
where a.facnum between 'F3507637' and 'F3507649'
order by a.facnum 

/*
insert into palmcomsync..in_factura
select * from palmcomsync..in_factura_temp
where facnum between 'F0718677  ' and 'F0718722  '
*/

select * from sitgpintegration..transaccionventaitem
where idventa  between '25913' and '25924'
