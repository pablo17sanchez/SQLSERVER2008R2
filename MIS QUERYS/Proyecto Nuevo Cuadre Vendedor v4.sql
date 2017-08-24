select A.SOPNUMBE, A.DOCDATE, A.DOCID, A.LOCNCODE, A.PRCLEVEL, A.BACHNUMB, A.CUSTNMBR, A.CUSTNAME, A.SLPRSNID, v.slprsnfn, v.sprsnsln, B.ITEMNMBR, B.ITEMDESC, B.QUANTITY, B.UNITPRCE, B.XTNDPRCE, A.PYMTRCVD,  (v.slprsnfn+''+v.sprsnsln)as Vendedor, c.USRDEF03, c.USRDEF05  from sop10100 A JOIN RM00301 V ON A.SLPRSNID = V.SLPRSNID JOIN SOP10200 B ON A.SOPNUMBE = B.SOPNUMBE left join SOP10106 c on a.SOPNUMBE = c.SOPNUMBE 
--WHERE (A.BACHNUMB IN(@BACHNUMB))



select A.SOPNUMBE, A.DOCDATE, A.DOCID, A.LOCNCODE, A.PRCLEVEL, A.BACHNUMB, A.CUSTNMBR, A.CUSTNAME, A.SLPRSNID from SOP10100 A UNION ALL select B.SOPNUMBE, B.DOCDATE, B.DOCID, B.LOCNCODE, B.PRCLEVEL, B.BACHNUMB, B.CUSTNMBR, B.CUSTNAME, B.SLPRSNID from SOP30200 B
