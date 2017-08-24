SELECT     dbo.GP_SUBZONA.IdZona, dbo.GP_SUBZONA.ZonaDesc, dbo.GP_SUBZONA.Descripcion, dbo.GP_SUBZONA.NombreSupervisor, 
                      dbo.GP_RUTA.NombreRuta, dbo.GP_RUTA.IdVendedor, dbo.GP_RUTA.NombreVendedor, (rtrim(rm.STMGRFNM) + ' ' + rtrim(rm.STMGRLNM))
                      AS NombreCoordinador
FROM         dbo.GP_SUBZONA INNER JOIN
                      dbo.GP_RUTA ON dbo.GP_SUBZONA.CodSubzona = dbo.GP_RUTA.CodSubZona INNER JOIN
                      dbo.GP_SUPERVISOR ON dbo.GP_SUBZONA.CodSupervisor = dbo.GP_SUPERVISOR.CodSupervisor INNER JOIN
                      GPHN.dbo.RM00303 AS rm ON dbo.GP_SUBZONA.IdZona = rm.SALSTERR