/*
select * from iv30701
where ivdocnbr = 'var000000255' and 'var000000236'
*/



---CONSULTA CONTEO HISTORICO POR BIN---
/*
 select a.stckcntid[ID DE CONTEO], a.locncode[LOCALIDAD], a.ITEMNMBR[ARTICULO], b.ITEMDESC , a.binnmbr [COMPARTIMIENTO], a.COUNTEDQTY [CANTIDAD CONTADA], a.CAPTUREDQTY [CANT. CAPTURADA], a.ivdocnbr[# VARIACION], a.varianceqty [VARIACION],a.unitcost[COSTO UNITARIO], b.stndcost[COSTO STANDAR], b.currcost [COSTO ACTUAL] from iv30701 a join 
iv00101 b on a.itemnmbr = b.itemnmbr
where ivdocnbr between  'var000000308' and 'var000000311' and a.COUNTEDQTY <> 0 
order by  a.itemnmbr
*/



---CONSULTA CONTEO HISTORICO POR ITEM---
/*
select  a.locncode[LOCALIDAD],a.itemnmbr[ARTICULO], b.ITEMDESC[DESCRIPCION], sum(COUNTEDQTY)[CANTIDAD CONTADA], sum (a.CAPTUREDQTY) [CANT. CAPTURADA], sum (a.varianceqty) [CANT.VARIACION],a.unitcost[COSTO UNITARIO], b.stndcost[COSTO STANDAR], b.currcost [COSTO ACTUAL] from iv30701 a join 
iv00101 b on a.itemnmbr = b.itemnmbr
where ivdocnbr BETWEEN 'var000000270' and 'var000000280'
group by a.itemnmbr, b.ITEMDESC, a.locncode, a.unitcost, b.stndcost, b.currcost
order by a.itemnmbr
*/
