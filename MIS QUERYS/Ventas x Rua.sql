select soph.docdate [Fecha Venta],month(docdate)[MesVenta],day(docdate)[DiaVenta],sop.itemnmbr,sop.itemdesc,cast(sop.unitprce as decimal(10,2))[Precio Unitario],sum(cast(sop.quantity as decimal(10,0))) [Cantidad],sum(cast((sop.unitprce * sop.quantity) as decimal(10,2))) [Valor Venta],rtrim(r.idvendedor) [IdVendedor],(rtrim(vp.slprsnfn)+' '+rtrim(vp.sprsnsln))  [NombreVendedor],r.nombreruta
from (select soptype,sopnumbe,itemnmbr,itemdesc,unitprce,quantity,(unitprce * quantity)'ValorVenta',salsterr,slprsnid  from sop10200
union all
select soptype,sopnumbe,itemnmbr,itemdesc,unitprce,quantity,(unitprce * quantity)'ValorVenta',salsterr,slprsnid from sop30300) sop join (select sopnumbe,docdate,slprsnid,salsterr from sop10100 
union all 
select sopnumbe,docdate,slprsnid,salsterr from sop30200) soph on sop.sopnumbe = soph.sopnumbe join rm00301 vp on soph.slprsnid = vp.slprsnid join palmcomsync..gp_ruta r on soph.slprsnid = r.idvendedor
where soptype = 3 and soph.docdate between @iFecha and  @aFecha  and r.nombreruta = @nombrerutagroup by docdate,month(docdate),day(docdate),sop.itemnmbr,sop.itemdesc,cast(sop.unitprce as decimal(10,2)) ,cast((sop.unitprce * sop.quantity) as decimal(10,2)) ,r.idvendedor,(rtrim(vp.slprsnfn)+' '+rtrim(vp.sprsnsln)),r.nombreruta