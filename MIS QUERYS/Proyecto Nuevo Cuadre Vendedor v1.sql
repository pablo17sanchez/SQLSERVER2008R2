

select c.TipoDocumento, a.BACHNUMB, a.DOCDATE, a.DOCNUMBR, b.ITEMNMBR, b.TRXQTY, b.TRNSTLOC , b.TRXLOCTN, c.CodRuta, c.IdVendedor, rtrim(d.slprsnfn) + ' ' + rtrim(d.sprsnsln), c.Ayudante1, rtrim(e.slprsnfn) + ' ' + rtrim(e.sprsnsln), c.Ayudante2 from IV30200 a join IV30300 b on a.DOCNUMBR = b.DOCNUMBR 
join SITGPIntegration..RelacionConduce c on a.BACHNUMB = c.NoDocumento  JOIN RM00301 d on c.IdVendedor = d.SLPRSNID join RM00301 e on c.Ayudante1 = e.SLPRSNID 
where c.NoDocumento = '000000000174732' 




select a.sopnumbe, a.DOCDATE, a.BACHNUMB, a.LOCNCODE, a.DOCAMNT  , b.ITEMNMBR, b.ITEMDESC, b.LOCNCODE, b.QUANTITY  from sop10100 a join SOP10200 b
on a.SOPNUMBE = b.SOPNUMBE   join SOP10106 c on a.SOPNUMBE = c.SOPNUMBE 
where c.userdef2 = '000000000174732'  and a.PYMTRCVD > '0'

select a.sopnumbe, a.DOCDATE, a.BACHNUMB, a.LOCNCODE, a.DOCAMNT  ,a.PYMTRCVD, b.ITEMNMBR, b.ITEMDESC, b.LOCNCODE, b.QUANTITY  from sop10100 a join SOP10200 b
on a.SOPNUMBE = b.SOPNUMBE   join SOP10106 c on a.SOPNUMBE = c.SOPNUMBE 

where c.userdef2 = '000000000174732'  




select a.NoDocumento , a.TipoDocumento , a.IdVendedor , a.Fecha , a.NumeroConduce , b.bachnumb, b.docdate, b.ortrxamt  from SITGPIntegration..RelacionConduce a join RM10201  b
on a.NoDocumento = b.DOCNUMBR 
where NumeroConduce = '000000000174732'

