
/*
select * from IV30300 
where DOCNUMBR = 'ADJ000005201'
order by ITEMNMBR 
*/
select  a.docnumbr, a.itemnmbr, a.locncode, a.bin, b.DOCDATE, b.TRXQTY from IV30302 a join IV30300 b
on  a.DOCNUMBR = b.DOCNUMBR and a.ITEMNMBR = b.ITEMNMBR 
where b.DOCDATE = '2010.12.31' and a.ITEMNMBR between '0' and '99999' and b.DOCTYPE <> '2'
group by b.DOCDATE, a.docnumbr, a.itemnmbr, a.locncode, a.bin, b.TRXQTY
order by a.DOCNUMBR 
/*
select * from IV30302 
*/