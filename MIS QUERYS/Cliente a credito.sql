SELECT DISTINCT 
                      TOP (100) PERCENT RTRIM(rm1.CUSTNMBR) AS CodCliente, RTRIM(rm1.CUSTNAME) AS NombCliente, rm1.CUSTCLAS AS IdClase, rm1.CNTCPRSN AS PersCont, 
                      rm1.ADDRESS1 AS Direccion1, rm1.ADDRESS2 AS Direccion2, rm1.ADDRESS3 AS Direccion3, rm1.COUNTRY AS Pais, rm1.CITY AS Ciudad, rm1.STATE, 
                      SUBSTRING(rm1.PHONE1, 1, 3) + '-' + SUBSTRING(rm1.PHONE1, 4, 7) AS Telefono1, SUBSTRING(rm1.PHONE2, 1, 3) + '-' + SUBSTRING(rm1.PHONE2, 4, 7) 
                      AS Telefono2, SUBSTRING(rm1.PHONE3, 1, 3) + '-' + SUBSTRING(rm1.PHONE3, 4, 7) AS Telefono3, SUBSTRING(rm1.FAX, 1, 3) + '-' + SUBSTRING(rm1.FAX, 4, 7) 
                      AS Fax, rm1.PYMTRMID AS IdPago,CASE WHEN CRLMTTYP=1 THEN 'ILIMITADO' WHEN CRLMTTYP=2 THEN 'CON MONTO'ELSE ' CONTADO'END,rm1.CRLMTAMT'LIMITE', rm1.COMMENT1 AS Comentario1, rm1.COMMENT2 AS Comentario2, rm1.USERDEF1 AS NCF, rm1.TXRGNNUM AS RNC, 
                      rm1.INACTIVE AS Inactivo, rm1.HOLD AS Suspendido, rm2.USERDEF1 AS Latitud, rm2.USERDEF2 AS Longitud, cr.NombreRuta, cr.IdVendedor, cr.NombreVendedor, 
                      cr.NombreSubZona AS NZonaSup, cr.NombreSupervisor, cr.IdZona, cr.ZonaDesc, cr.ZonaResp AS ZonaResponsable, rm1.CREATDDT AS FechaCreacion, 
                      dbo.fn_UltimaFecha(rm1.CUSTNMBR) AS UltFecFact, rm1.PRCLEVEL
FROM         dbo.RM00101 AS rm1 LEFT OUTER JOIN
                      PalmComSync.dbo.vw_Clientes_CSR AS cr ON rm1.CUSTNMBR = cr.CodCliente INNER JOIN
                      dbo.RM00102 AS rm2 ON rm1.CUSTNMBR = rm2.CUSTNMBR
WHERE     (rm1.CUSTCLAS NOT IN ('vendedor')) AND (rm1.HOLD = 0) AND rm1.CRLMTTYP<>0 AND cr.NombreRuta<>'' AND IdZona IN ('GA-01','GA-02','GA-03','GA-04','GA-05')
GROUP BY RTRIM(rm1.CUSTNMBR), RTRIM(rm1.CUSTNAME), rm1.CUSTCLAS, rm1.CNTCPRSN, rm1.ADDRESS1, rm1.ADDRESS2, rm1.ADDRESS3, rm1.COUNTRY, rm1.CITY, 
                      rm1.STATE, SUBSTRING(rm1.PHONE1, 1, 3) + '-' + SUBSTRING(rm1.PHONE1, 4, 7), SUBSTRING(rm1.PHONE2, 1, 3) + '-' + SUBSTRING(rm1.PHONE2, 4, 7), 
                      SUBSTRING(rm1.PHONE3, 1, 3) + '-' + SUBSTRING(rm1.PHONE3, 4, 7), SUBSTRING(rm1.FAX, 1, 3) + '-' + SUBSTRING(rm1.FAX, 4, 7), rm1.PYMTRMID, 
                      rm1.COMMENT1, rm1.COMMENT2, rm1.USERDEF1, rm1.TXRGNNUM, rm1.INACTIVE, rm1.HOLD, rm2.USERDEF1, rm2.USERDEF2, cr.NombreRuta, cr.IdVendedor, 
                      cr.NombreVendedor, cr.NombreSubZona, cr.NombreSupervisor, cr.IdZona, cr.ZonaDesc, cr.ZonaResp, rm1.CREATDDT, dbo.fn_UltimaFecha(rm1.CUSTNMBR), 
                      rm1.PRCLEVEL,CRLMTTYP,rm1.CRLMTAMT
ORDER BY CodCliente