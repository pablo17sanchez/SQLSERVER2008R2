SELECT     Month(a.DOCDATE)[Mes], b.ITEMNMBR, b.ITEMDESC, a.LOCNCODE, b.UNITPRCE, sum(b.QUANTITY)Cantidad FROM         dbo.SOP30200 AS a INNER JOIN
                      dbo.SOP30300 AS b ON a.SOPNUMBE = b.SOPNUMBE
WHERE     (a.SOPTYPE = '3') AND (a.DOCID IN ('a0100800101', 'a0100800114', 'a0100800115')) AND (a.DOCDATE BETWEEN '2009.01.01' AND '2009.07.31') AND 
                      (b.ITEMNMBR = 'pt600') and unitprce in ('17','20','25')
group by Month(a.DOCDATE), b.ITEMNMBR, b.ITEMDESC, a.LOCNCODE, b.UNITPRCE
--select * from sop30200