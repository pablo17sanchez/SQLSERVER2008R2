select * from SOP10200 
where ReqShipDate < '2011.03.03'



select  distinct a.itemnmbr, a.LOCNCODE from SOP10200 a join sop10100 b
on a.SOPNUMBE = b.SOPNUMBE 
where DOCDATE  between '2011.02.07' and '2011.03.02'
ORDER BY LOCNCODE, ITEMNMBR
