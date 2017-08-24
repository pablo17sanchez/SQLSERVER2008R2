DECLARE @FECHA DATETIME
DECLARE @idZona NVARCHAR(10),@PROD NVARCHAR(10)

SET @FECHA='20160314'
SET @idZona='GA-01'
SET @PROD='PT100'



SELECT  [Codigo]
      ,[CodCliente]
      ,[Nombre]
      ,[PERS_CONTACT]
      ,[PHONE1]
      ,[PHONE2]
      ,[CodRuta]
      ,[NombreRuta]
      ,[IdZona]
      ,[ZonaResp]
      ,[NOMBREVEND]
      ,[Lunes]
      ,[Martes]
      ,[Miercoles]
      ,[Jueves]
      ,[Viernes]
      ,[Sabado]
      ,[Domingo]
      ,[DATE]
      ,[usuario]
      ,[FECHAMODIF]
      ,[TIPOVENDEDOR]
      ,[ID]
      ,[PALMID]
      ,c.[IDVENDEDOR]
      ,[FECHA]
      ,[GPHN].[dbo].[fn_devuelveFacturadoPalm](@FECHA,[CodCliente],c.[IDVENDEDOR])'FACTURA'
      ,[GPHN].[dbo].[fn_devuelveVisitaPalm](@FECHA,[CodCliente],[PALMID])'NO_VISITA'
      ,CD.CANT_COND
      ,CD.C1
      ,CD.C2
      ,vts.CANT
  FROM [DataRS].[dbo].[vw_ruta_sustitutos_vendedor_h] c 
  INNER JOIN (
  SELECT  IdVendedor,
          COUNT(ORDDOCID)CANT_COND,
          ITEMNMBR,
          SUM([1])'C1',
          SUM([2])'C2' 
 FROM (
	SELECT c.IdVendedor,
		   a.ORDDOCID,
		   a.ITEMNMBR,
	     
		   ISNULL(CASE WHEN RANK() OVER (PARTITION BY a.TRNSTLOC ORDER BY a.ORDDOCID )=1 THEN a.TRNSFQTY END,0)'1', 
		   ISNULL(CASE WHEN RANK() OVER (PARTITION BY a.TRNSTLOC ORDER BY a.ORDDOCID)=2 THEN a.TRNSFQTY END,0)'2' 
	       
	FROM (
	       SELECT ORDDOCID,
	              ITEMNMBR,
	              TRNSFQTY,
	              TRNSTLOC   
	       FROM GPHN.dbo.SVC30701 
           UNION ALL
	       SELECT 
	           ORDDOCID,
	           ITEMNMBR,
	           TRNSFQTY,
	           TRNSTLOC  FROM SVC00701

	 
	      ) a	
	  LEFT JOIN  SITGPIntegration..RelacionConduce c ON a.ORDDOCID=c.NoDocumento
	  WHERE Fecha=@FECHA 
	    AND TipoDocumento='Conduce'  
	   AND a.ITEMNMBR=@PROD
	GROUP BY c.IdVendedor,
	         a.ITEMNMBR,
	         a.ORDDOCID,
	         a.TRNSFQTY,
	         a.TRNSTLOC 
	         ) b
GROUP BY IdVendedor,ITEMNMBR) cd ON c.IDVENDEDOR=cd.IdVendedor LEFT JOIN
 (        SELECT IdVendedor,
                 SUM(QUANTITY)'CANT' 
                 FROM GPHN..vw_VentasGP
           WHERE  DOCDATE =@FECHA AND ITEMNMBR=@PROD
            GROUP BY IdVendedor--,ITEMNMBR
) vts ON c.IDVENDEDOR=vts.IdVendedor
  WHERE [DATE]=@FECHA AND [NombreRuta] LIKE CASE @PROD WHEN 'PT100' THEN   'SD1%'
                                                       WHEN 'PT300' THEN   'SD3%' 
                                                       END AND [IdZona]=@idZona
  GROUP BY   [Codigo]
      ,[CodCliente]
      ,[Nombre]
      ,[PERS_CONTACT]
      ,[PHONE1]
      ,[PHONE2]
      ,[CodRuta]
      ,[NombreRuta]
      ,[IdZona]
      ,[ZonaResp]
      ,[NOMBREVEND]
      ,[Lunes]
      ,[Martes]
      ,[Miercoles]
      ,[Jueves]
      ,[Viernes]
      ,[Sabado]
      ,[Domingo]
      ,[DATE]
      ,[usuario]
      ,[FECHAMODIF]
      ,[TIPOVENDEDOR]
      ,[ID]
      ,[PALMID]
      ,c.[IDVENDEDOR]
      ,[FECHA]
      ,CD.CANT_COND
      ,CD.C1
      ,CD.C2
      ,vts.CANT
  ORDER BY CodRuta