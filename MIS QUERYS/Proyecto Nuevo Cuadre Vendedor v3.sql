SELECT     c.TipoDocumento, a.BACHNUMB, a.DOCDATE, a.DOCNUMBR, b.ITEMNMBR, b.TRXQTY, b.TRNSTLOC, b.TRXLOCTN, c.CodRuta, c.IdVendedor, RTRIM(c.IdVendedor) 
                      + '  ' + d.SLPRSNFN + ' ' + RTRIM(d.SPRSNSLN)+ ' ' + RTRIM(b.TRXLOCTN) 
                      FROM         IV30200 AS a INNER JOIN
                      IV30300 AS b ON a.DOCNUMBR = b.DOCNUMBR INNER JOIN
                      SITGPIntegration.dbo.RelacionConduce AS c ON a.BACHNUMB = c.NoDocumento INNER JOIN
                      RM00301 AS d ON c.IdVendedor = d.SLPRSNID INNER JOIN 
                      RM00301 AS e ON c.Ayudante1 = e.SLPRSNID
WHERE     (c.IdVendedor = @VENDEDOR)