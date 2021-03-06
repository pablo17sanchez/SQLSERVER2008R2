USE [GPHN]
GO
/****** Object:  StoredProcedure [dbo].[sp_reporteVentadelDia]    Script Date: 04/11/2014 08:16:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_reporteVentadelDia]
	-- Add the parameters for the stored procedure here
	 @IFECHA DATETIME, 
	 @AFECHA DATETIME, 
	 @PROD VARCHAR(20),
	 @LOCALIDAD VARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
IF (MONTH(@IFECHA)=1 AND MONTH(@AFECHA)=1) 
BEGIN

SELECT  A.NombreSupervisor,A.NombreRuta,SUM(A.VentaA)'MesAnual',SUM(A.VentaM)'Mensual' , LOCNCODE,
       ITEMNMBR, NombreVendedor INTO ##VENTA FROM (
SELECT s.NombreSupervisor,NombreRuta, 
       SUM(QUANTITY)'VentaA',
       0'VentaM',
       LOCNCODE,
       ITEMNMBR,
       s.NombreVendedor
     
       
  FROM [GPHN].[dbo].[view_VentaGPruta] v INNER JOIN dbo.vw_Ruta_Clientes s ON v.CUSTNMBR=s.CodCliente 
  WHERE DOCDATE BETWEEN CONVERT (CHAR(20), CONVERT(CHAR(4), YEAR(@IFECHA)-1)+'/0'+CONVERT(CHAR(1), MONTH(@IFECHA)+3)+'/01', 111)  AND DATEADD(dd, DATEPART(dd, @IFECHA)* -1, @IFECHA) AND LOCNCODE=@LOCALIDAD AND ITEMNMBR=@PROD /* AND 
  NombreRuta LIKE CASE WHEN @PROD='PT100' AND @LOCALIDAD='SANISIDRO' THEN '%SD1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='SANISIDRO' THEN '%SD3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='ROMANA' THEN '%RO1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='ROMANA' THEN '%RO3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='BAVARO' THEN '%BA1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='BAVARO' THEN '%BA3%' 
                       END*/
GROUP BY NombreRuta, s.NombreSupervisor, LOCNCODE,
       ITEMNMBR,s.NombreVendedor
UNION ALL
SELECT  s.NombreSupervisor,NombreRuta, 
       0'VentaA',
       SUM(QUANTITY)'VentaM',
       LOCNCODE,
       ITEMNMBR,
       s.NombreVendedor
      
       
  FROM [GPHN].[dbo].[view_VentaGPruta] v INNER JOIN dbo.vw_Ruta_Clientes s ON v.CUSTNMBR=s.CodCliente
  WHERE DOCDATE BETWEEN @IFECHA AND @AFECHA  AND LOCNCODE=@LOCALIDAD AND ITEMNMBR=@PROD AND DOCID NOT IN ('A0100800101','MANUAL')/* AND 
  NombreRuta LIKE CASE WHEN @PROD='PT100' AND @LOCALIDAD='SANISIDRO' THEN '%SD1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='SANISIDRO' THEN '%SD3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='ROMANA' THEN '%RO1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='ROMANA' THEN '%RO3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='BAVARO' THEN '%BA1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='BAVARO' THEN '%BA3%' 
                       END*/
  GROUP BY NombreRuta, s.NombreSupervisor, LOCNCODE,
       ITEMNMBR,s.NombreVendedor
) A
GROUP BY A.NombreRuta, A.NombreSupervisor,  LOCNCODE,
       ITEMNMBR, NombreVendedor
       
       
       
SELECT DISTINCT NombreSupervisor,NombreRuta,MesAnual,Mensual , LOCNCODE,
       ITEMNMBR, NombreVendedor FROM ##VENTA
       WHERE  LOCNCODE=@LOCALIDAD AND ITEMNMBR=@PROD AND 
  NombreRuta  LIKE CASE WHEN @PROD='PT100' AND @LOCALIDAD='SANISIDRO' THEN '%SD1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='SANISIDRO' THEN '%SD3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='ROMANA' THEN '%RO1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='ROMANA' THEN '%RO3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='BAVARO' THEN '%BA1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='BAVARO' THEN '%BA3%' 
                       END
   DROP TABLE ##VENTA   
END 
ELSE  

BEGIN 
SELECT  R.NombreSupervisor,R.NombreRuta,SUM(A.VentaA)'MesAnual',SUM(A.VentaM)'Mensual' , LOCNCODE,
       ITEMNMBR,NombreVendedor --INTO ##VENTAA 
       FROM (
SELECT --s.NombreSupervisor,s.NombreRuta, 
       CUSTNMBR,
       SUM(QUANTITY)'VentaA',
       0'VentaM',
       LOCNCODE,
       ITEMNMBR--,
       --s.NombreVendedor
     
       
   FROM [GPHN].[dbo].[vw_VentasGP] --v INNER JOIN dbo.vw_Ruta_Clientes s ON v.CUSTNMBR=s.CodCliente 
  WHERE DOCDATE BETWEEN CONVERT (CHAR(20), CONVERT(CHAR(4), YEAR(@IFECHA)) + '-01-01', 111) AND DATEADD(dd, DATEPART(dd, @IFECHA)* -1, @IFECHA) AND LOCNCODE=@LOCALIDAD  AND ITEMNMBR=@PROD
  AND DOCID NOT IN ('A0100800101','MANUAL') /*AND 
  NombreRuta LIKE CASE WHEN @PROD='PT100' AND @LOCALIDAD='SANISIDRO' THEN '%SD1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='SANISIDRO' THEN '%SD3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='ROMANA' THEN '%RO1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='ROMANA' THEN '%RO3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='BAVARO' THEN '%BA1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='BAVARO' THEN '%BA3%' 
                       END*/
GROUP BY --s.NombreRuta, s.NombreSupervisor, 
LOCNCODE,ITEMNMBR,CUSTNMBR--, s.NombreVendedor
UNION ALL
SELECT  --s.NombreSupervisor,s.NombreRuta, 
       CUSTNMBR,
       0'VentaA',
       SUM(QUANTITY)'VentaM',
       LOCNCODE,
       ITEMNMBR--,
      -- s.NombreVendedor
      
       
    FROM [GPHN].[dbo].[vw_VentasGP] --v INNER JOIN dbo.vw_Ruta_Clientes s ON v.CUSTNMBR=s.CodCliente 
  WHERE DOCDATE BETWEEN @IFECHA AND @AFECHA  AND LOCNCODE=@LOCALIDAD AND ITEMNMBR=@PROD AND DOCID NOT IN ('A0100800101','MANUAL') /*AND 
  NombreRuta LIKE CASE WHEN @PROD='PT100' AND @LOCALIDAD='SANISIDRO' THEN '%SD1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='SANISIDRO' THEN '%SD3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='ROMANA' THEN '%RO1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='ROMANA' THEN '%RO3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='BAVARO' THEN '%BA1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='BAVARO' THEN '%BA3%' 
                       END*/
  GROUP BY --s.NombreRuta, s.NombreSupervisor , 
  LOCNCODE, ITEMNMBR,CUSTNMBR--, s.NombreVendedor
) A INNER JOIN PalmComSync..vw_gp_ClienteDiasRutaZona R ON A.CUSTNMBR=R.CodCliente 
WHERE  LOCNCODE=@LOCALIDAD AND ITEMNMBR=@PROD AND 
  NombreRuta  LIKE CASE WHEN @PROD='PT100' AND @LOCALIDAD='SANISIDRO' THEN '%SD1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='SANISIDRO' THEN '%SD3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='ROMANA' THEN '%RO1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='ROMANA' THEN '%RO3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='BAVARO' THEN '%BA1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='BAVARO' THEN '%BA3%' 
                       END
GROUP BY R.NombreRuta, R.NombreSupervisor,  
LOCNCODE,ITEMNMBR, NombreVendedor
     /*  
       
SELECT DISTINCT NombreSupervisor,NombreRuta,MesAnual,Mensual , LOCNCODE,
       ITEMNMBR, NombreVendedor FROM ##VENTAA
       WHERE  LOCNCODE=@LOCALIDAD AND ITEMNMBR=@PROD AND 
  NombreRuta  LIKE CASE WHEN @PROD='PT100' AND @LOCALIDAD='SANISIDRO' THEN '%SD1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='SANISIDRO' THEN '%SD3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='ROMANA' THEN '%RO1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='ROMANA' THEN '%RO3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='BAVARO' THEN '%BA1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='BAVARO' THEN '%BA3%' 
                       END
   DROP TABLE ##VENTAA  */
END

                
END
/*SELECT TOP 1000 * FROM dbo.vw_Ruta_Clientes
WHERE NombreRuta='SD100-21'
ORDER BY CodCliente*/