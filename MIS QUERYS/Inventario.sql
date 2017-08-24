--****CONSULTA ARTICULOS AGRUPADOS FINAL****--

select a.ITEMNMBR[ARTICULO],b.ITEMDESC ,sum(a.COUNTEDQTY)[CANTIDAD CONTADA], SUM (a.CAPTUREDQTY) [EXISTENCIA], sum (a.varianceqty)[VARIACION], b.stndcost[COSTO STANDAR], b.currcost [COSTO ACTUAL] from iv10301 a join 
iv00101 b on a.itemnmbr = b.itemnmbr
where stckcntid like 'bavaro 2-10%' --or stckcntid = 'bav-20100809-2' --and a.countedqty > 0 
 group by a.ITEMNMBR ,b.itemdesc, b.stndcost, b.currcost 
order by a.ITEMNMBR


--****CONSULTA ARTICULOS POR COMPARTIMIENTOS FINAL****--

 select a.ITEMNMBR[ARTICULO], b.ITEMDESC , a.binnmbr [COMPARTIMIENTO], a.COUNTEDQTY [CANTIDAD CONTADA], a.CAPTUREDQTY [EXISTENCIA], a.varianceqty [VARIACION], b.stndcost[COSTO STANDAR], b.currcost [COSTO ACTUAL] from iv10301 a join 
iv00101 b on a.itemnmbr = b.itemnmbr
where stckcntid like 'bavaro 2-10%' --or stckcntid = 'bav-20100809-2' ---and countedqty > '0' --OR  stckcntid = 'COMP-SI 4-09'  OR  stckcntid = 'COMP2-SI 4-09'  
order by  a.varianceqty
