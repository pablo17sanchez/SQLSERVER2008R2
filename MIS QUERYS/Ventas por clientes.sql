SELECT     C.CodCliente, C.NombCliente, V.DOCDATE, V.SLPRSNID, V.ITEMNMBR, V.ITEMDESC, V.LOCNCODE, SUM(V.QUANTITY) AS Quantity, SUM(V.XTNDPRCE) 
                      AS XTNDPRCE, RZ.NombreRuta, RZ.NombreSubZona, RZ.IdZona, RZ.ZonaResp, RZ.NombreSupervisor, 
                      rtrim(RV.SLPRSNFN) + ' ' + rtrim(RV.SPRSNSLN) AS NombreVendedor
FROM         dbo.vw_VentasGP AS V INNER JOIN
                      dbo.VW_ClientesGP AS C ON V.CUSTNMBR = C.CodCliente INNER JOIN
                      dbo.RM00301 AS RV ON V.SLPRSNID = RV.SLPRSNID LEFT OUTER JOIN
                      PalmComSync.dbo.vw_RutaZona AS RZ ON V.SLPRSNID = RZ.IdVendedor
WHERE     (V.DOCDATE BETWEEN '2009.06.01' AND '2009.06.30') AND (V.ITEMNMBR = 'pt300')
GROUP BY C.CodCliente, C.NombCliente, V.DOCDATE, V.SLPRSNID, V.ITEMNMBR, V.ITEMDESC, V.LOCNCODE, RZ.NombreRuta, RZ.NombreSubZona, 
                      RZ.IdZona, RZ.ZonaResp, RZ.NombreSupervisor, rtrim(RV.SLPRSNFN) + ' ' + rtrim(RV.SPRSNSLN)