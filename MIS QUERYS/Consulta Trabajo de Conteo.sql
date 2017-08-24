/*
/*
select * from iv10301
where stckcntid = 'prueba' and COUNTEDQTY > '0'
ORDER BY LOCNCODE
*/

/*

select ITEMNMBR, COUNT (*) from iv10301
where stckcntid = 'sanisidro 4-09' 
GROUP BY ITEMNMBR
ORDER BY ITEMNMBR
*/

/*
select ITEMNMBR [ARTICULO],sum(COUNTEDQTY)[CANTIDAD CONTADA], SUM (CAPTUREDQTY) [EXISTENCIA], sum (varianceqty)[VARIACION] from iv10301
where stckcntid = 'sanisidro 4-09'and COUNTEDQTY > '0'
 group by itemnmbr
order by VARIACION
*/

/*
select itemnmbr, sum(COUNTEDQTY)[cantidad] from iv10301
where stckcntid = 'sanisidro 4-09'and COUNTEDQTY > '0'
group by itemnmbr
order by itemnmbr
*/

/*
select a.ITEMNMBR[ARTICULO],b.ITEMDESC ,sum(a.COUNTEDQTY)[CANTIDAD CONTADA], SUM (a.CAPTUREDQTY) [EXISTENCIA], sum (a.varianceqty)[VARIACION], B. from iv10301 a join 
iv00101 b on a.itemnmbr = b.itemnmbr
where stckcntid = 'sanisidro 01-11' --and COUNTEDQTY > '0'
 group by a.ITEMNMBR ,b.itemdesc
order by a.ITEMNMBR
*/

----select * from iv10301

--****CONSULTA ARTICULOS AGRUPADOS FINAL****--

select a.ITEMNMBR[ARTICULO],b.ITEMDESC ,sum(a.COUNTEDQTY)[CANTIDAD CONTADA], SUM (a.CAPTUREDQTY) [EXISTENCIA], sum (a.varianceqty)[VARIACION], b.stndcost[COSTO STANDAR], b.currcost [COSTO ACTUAL] from iv10301 a join 
iv00101 b on a.itemnmbr = b.itemnmbr
where stckcntid = 'bav 02-16' --or stckcntid = 'SAN 01-15 COMPL' --and a.countedqty <> 0 --or stckcntid like 'bavaro 01-11' ---or stckcntid like 'bavaro 4-10' or stckcntid like 'bavaroc 4-10' or stckcntid like 'romana 4-10'---and countedqty > '0' --or stckcntid = 'bav-20100809-2' --and a.countedqty > 0 
 group by a.ITEMNMBR ,b.itemdesc, b.stndcost, b.currcost 
order by a.ITEMNMBR


--****CONSULTA ARTICULOS POR COMPARTIMIENTOS FINAL****--

 select a.ITEMNMBR[ARTICULO], b.ITEMDESC , a.binnmbr [COMPARTIMIENTO], a.COUNTEDQTY [CANTIDAD CONTADA], a.CAPTUREDQTY [EXISTENCIA], a.varianceqty [VARIACION], b.stndcost[COSTO STANDAR], b.currcost [COSTO ACTUAL] from iv10301 a join 
iv00101 b on a.itemnmbr = b.itemnmbr
where stckcntid = 'bav 02-16' ---and a.itemnmbr = '8199' --or stckcntid = 'SAN 01-15 COMPL' --and a.countedqty <> 0 --or stckcntid like 'bavaro 01-11' ---and a.countedqty <> 0 --or stckcntid like 'bavaro 4-10' or stckcntid like 'bavaroc 4-10' or stckcntid like 'romana 4-10' --and countedqty > '0' --or stckcntid = 'bav-20100809-2' ---and countedqty > '0' --OR  stckcntid = 'COMP-SI 4-09'  OR  stckcntid = 'COMP2-SI 4-09'  
order by a.binnmbr,  a.itemnmbr

----*****CONSULTA CANTIDAD ARTICULOS EN LA TABLA CANTIDAD DE COMPARTIMIENTO****----- 
--select ITEMNMBR, QTYONHND from iv00102
*/

select * from IV10301
where ITEMNMBR = '8471'

select * from iv10301
where stckcntid = 'sanisidro 4-10' and ITEMNMBR like 'ot%' ---AND verified = '1' --and CAPTUREDQTY <> '0'
order by ITEMNMBR

/*


 select a.ITEMNMBR[ARTICULO], b.ITEMDESC , a.binnmbr [COMPARTIMIENTO], a.COUNTEDQTY [CANTIDAD CONTADA], a.CAPTUREDQTY [EXISTENCIA], a.varianceqty [VARIACION], b.stndcost[COSTO STANDAR], b.currcost [COSTO ACTUAL] from iv10301 a join 
iv00101 b on a.itemnmbr = b.itemnmbr
where stckcntid like '%2-10' --and countedqty > '0' 
order by  a.varianceqty
*/


select * from iv10301
where stckcntid = 'BAVARO-20100809' and ITEMNMBR BETWEEN 'OT004' AND 'PT701'
order by countdate

/*
update iv10301
set verified = '1'
where stckcntid like '%2-10'
*/