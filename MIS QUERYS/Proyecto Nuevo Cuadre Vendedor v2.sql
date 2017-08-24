

select c.TipoDocumento, a.BACHNUMB, a.DOCDATE, a.DOCNUMBR, b.ITEMNMBR, b.TRXQTY, b.TRNSTLOC , b.TRXLOCTN, c.CodRuta, c.IdVendedor, rtrim(d.slprsnfn) + ' ' + rtrim(d.sprsnsln), c.Ayudante1, rtrim(e.slprsnfn) + ' ' + rtrim(e.sprsnsln), c.Ayudante2, g.sopnumbe, g.DOCDATE, g.BACHNUMB, g.LOCNCODE, g.DOCAMNT  ,g.PYMTRCVD, h.ITEMNMBR,h.ITEMDESC, h.LOCNCODE, h.QUANTITY  from IV30200 a join IV30300 b on a.DOCNUMBR = b.DOCNUMBR 
join SITGPIntegration..RelacionConduce c on a.BACHNUMB = c.NoDocumento  JOIN RM00301 d on c.IdVendedor = d.SLPRSNID join RM00301 e on c.Ayudante1 = e.SLPRSNID join SOP10106 f on c.NoDocumento  = f.userdef2 join sop10100 g on f.SOPNUMBE = g.SOPNUMBE join SOP10200 h on g.SOPNUMBE = h.SOPNUMBE 
where c.NoDocumento = '000000000174732' 







select g.sopnumbe, gDOCDATE, g.BACHNUMB, g.LOCNCODE, g.DOCAMNT  ,g.PYMTRCVD, h.ITEMNMBR,h.ITEMDESC, h.LOCNCODE, h.QUANTITY , from sop10100 a join SOP10200 b
on a.SOPNUMBE = b.SOPNUMBE   join SOP10106 c on a.SOPNUMBE = c.SOPNUMBE 

where c.userdef2 = '000000000174732' 

 