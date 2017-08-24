select *,DocDate,Custnmbr,Custname,Slprsnid,itemnmbr,itemdesc,unitprce,quantity,docamnt,locncode,nombreruta,idvendedor,nombrevendedor,nombresubzona,nombresupervisor,idzona,zonaresp from vw_ventasgp v Left join palmcomsync..vw_rutazona iv
on v.slprsnid = iv.idvendedor
where docdate = '2009.01.10'