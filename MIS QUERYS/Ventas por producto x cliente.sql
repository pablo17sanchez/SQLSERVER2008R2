select sp.custnmbr[NumeroCliente],sp.custname[NombreCliente],month(sp.docdate)[FechaDoc],sp.slprsnid[IdVendedor],rtrim(rm.slprsnfn)+' '+rtrim(rm.sprsnsln)[NombreVendedor],sp.itemnmbr[NoArticulo],sp.itemdesc[ArtDescripcion],sp.locncode[Localidad],sp.unitprce[PrecUnitario],sp.quantity[Cantidad],sp.xtndprce[MontoTotal] from (select sp1.custnmbr,sp1.custname,sp1.sopnumbe,sp1.docdate,sp1.slprsnid,sp2.itemnmbr,sp2.itemdesc,sp1.locncode,sp2.unitprce,sp2.quantity,sp2.xtndprce from sop10100 sp1 join sop10200 sp2
on sp1.sopnumbe = sp2.sopnumbe
where sp1.soptype = 3 and sp1.voidstts = 0
union all
select sp3.custnmbr,sp3.custname,sp3.sopnumbe,sp3.docdate,sp3.slprsnid,sp4.itemnmbr,sp4.itemdesc,sp3.locncode,sp4.unitprce,sp4.quantity,sp4.xtndprce from sop30200 sp3 join sop30300 sp4
on sp3.sopnumbe = sp4.sopnumbe
where sp3.soptype = 3 and  sp3.voidstts = 0)sp join rm00301 rm on sp.slprsnid = rm.slprsnid  join sop10106 sp1 on sp.sopnumbe = sp1.sopnumbe 
where month(sp.docdate) between '7' and '9' and sp.itemnmbr in @Articulo
group by sp.custnmbr,sp.custname,month(sp.docdate),sp.slprsnid,rtrim(rm.slprsnfn)+' '+rtrim(rm.sprsnsln),sp.itemnmbr,sp.itemdesc,sp.locncode,sp.unitprce,sp.quantity,sp.xtndprce