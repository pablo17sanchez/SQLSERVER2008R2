USE [SITGPIntegration]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerUltimosConduces]    Script Date: 04/25/2012 13:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[spObtenerUltimosConduces]
(
	@VendedorID AS VARCHAR (50)
)
AS
--SELECT ri.NumeroConduce, ri.Fecha, co.CodRuta AS Ruta FROM  RelacionConduce ri
--INNER JOIN  RelacionConduce co
--ON ri.NumeroConduce = co.NoDocumento

--WHERE ri.IDVendedor = @VendedorID AND ri.TipoDocumento = 'Conduce'
--ORDER BY Fecha DESC



SELECT TOP 5 rc.NoDocumento AS NumeroConduce, rc.Fecha, rc.CodRuta AS Ruta FROM RelacionConduce rc
WHERE IdVendedor = @VendedorID AND rc.TipoDocumento = 'Conduce' 
AND NoDocumento NOT IN (SELECT NumeroConduce FROM RelacionConduce)

