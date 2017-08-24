select a.ITEMNMBR, a.ITEMDESC, a.LOCNCODE, a.CSLSINDX, a.SLSINDX, b.DOCDATE   from SOP10200 a join sop10100 b
on a.SOPNUMBE = b.SOPNUMBE
where b.DOCDATE  between '2011.02.07' and  '2011.03.02' and a.itemnmbr  between 'PT100' and 'PT210' and a.LOCNCODE LIKE 'SI%' --AND 'PUESTO32'
order by b.DOCDATE 

/*

update   sop10200

set slsindx = '696', cslsindx = '705'
 from SOP10200 a join sop10100 b
on a.SOPNUMBE = b.SOPNUMBE 
where b.DOCDATE  between '2011.02.07' and  '2011.03.02' and a.itemnmbr  between 'PT100' and 'PT210' and a.LOCNCODE LIKE 'SI%' --AND 'PUESTO32'
*/


/*
update SOP10200 
set slsindx = '694', cslsindx = '702'
 from SOP10200 a join sop10100 b
on a.SOPNUMBE = b.SOPNUMBE 
where b.DOCDATE  < '2011.03.03' and a.itemnmbr between 'pt300' and 'pt800' and a.LOCNCODE = 'sanisidro'
*/