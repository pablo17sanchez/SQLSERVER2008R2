use two 
DECLARE 

@iArticulo nvarchar(20),
@sArticulo nvarchar(20),
@iFecha Datetime,
@aFecha Datetime,
@Clase nvarchar(20)

SET @iArticulo = '0023'
SET @sArticulo = '0023'
SET @iFecha = '2009.12.01'
SET @aFecha = '2010.01.14'
SET @Clase = ''

select iv1.itemnmbr Item,iv1.itemdesc Descripcion,(select qtyonhnd from iv00102
where locncode = '' and itemnmbr = iv1.itemnmbr) CantExistencia,iv1.currcost CostoActual,iv1.itmclscd IdClase,it.docnumbr,it.docdate,it.itemnmbr,it.trxqty,it.unitcost,it.extdcost,it.trxloctn,it.trnstloc FROM iv00101 iv1 join iv40400 iv3 on iv1.itmclscd = iv3.itmclscd join 
(select iv1.ivdocnbr docnumbr,iv1.docdate,iv2.itemnmbr,iv2.trxqty,iv2.unitcost,iv2.extdcost,iv2.trxloctn,iv2.trnstloc from iv10000 iv1 join iv10001 iv2 
on iv1.ivdocnbr =iv2.ivdocnbr 
union all
select iv3.docnumbr ,iv3.docdate,iv4.itemnmbr,iv4.trxqty,iv4.unitcost,iv4.extdcost,iv4.trxloctn,iv4.trnstloc from iv30200 iv3 join iv30300 iv4
on iv3.docnumbr = iv4.docnumbr
union all
select rcptnmbr docnumbr,daterecd,itemnmbr,qtyrecvd trxqty,unitcost,(unitcost*qtyrecvd)extdcost,trxloctn,'' from iv10200  
where pchsrcty = '5'
)it on iv1.itemnmbr = it.itemnmbr
where it.docdate between @iFecha and @aFecha and iv1.itemnmbr between @iArticulo and @sArticulo or iv1.itmclscd = @Clase
group by iv1.itemnmbr ,iv1.itemdesc ,iv1.currcost,iv1.itmclscd,it.docnumbr,it.docdate,it.itemnmbr,it.trxqty,it.unitcost,it.extdcost,it.trxloctn,it.trnstloc
order by it.docdate
