/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @FECHA DATE
--DECLARE @CODCLIENTE NVARCHAR(15)

SET @FECHA='20160106'

SELECT   [Codigo]
      ,[CodCliente]
      ,[Nombre]
      ,[PERS_CONTACT]
      ,[PHONE1]
      ,[PHONE2]
      ,[CodRuta]
      ,[NombreRuta]
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
      ,f.[IDVENDEDOR]
      ,[FECHA]
      ,[GPHN].[dbo].[fn_devuelveFacturadoPalm](@FECHA,[CodCliente],f.[IDVENDEDOR])'FACTURA'
      ,[GPHN].[dbo].[fn_devuelveVisitaPalm](@FECHA,[CodCliente],[PALMID])'NO_VISITA'
       ,f2.total_CantNoF 
  FROM [DataRS].[dbo].[vw_ruta_sustitutos_vendedor_h] as f 
  INNER JOIN (SELECT f1.idvendedor,COUNT(*)total_CantNoF,f1.FECHAFAC FROM PalmComSync..IN_FACTURA_TEMP f1
																				WHERE f1.CODCLIE IN (
												SELECT CODCLIE FROM PalmComSync..GP_CLIENTEDIASRUTA
													WHERE CASE DATEPART(WEEKDAY,@FECHA) WHEN 1 THEN Domingo 
													WHEN 2 THEN Lunes 
													WHEN 3 THEN Martes
													WHEN 4 THEN Miercoles
													WHEN 5 THEN Jueves
													WHEN 6 THEN Viernes
													WHEN 7 THEN Sabado END<>1 )
													GROUP BY f1.idvendedor,f1.FECHAFAC ) f2 ON f.IDVENDEDOR=f2.idvendedor and  f2.FECHAFAC=@FECHA
  WHERE [DATE]=@FECHA  
  GROUP BY   [Codigo]
      ,[CodCliente]
      ,[Nombre]
      ,[PERS_CONTACT]
      ,[PHONE1]
      ,[PHONE2]
      ,[CodRuta]
      ,[NombreRuta]
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
      ,f.[IDVENDEDOR]
      ,[FECHA]
      ,f2.total_CantNoF 
      ,f2.idvendedor
  ORDER BY CodCliente
  

  
  ----CXP--
          --|___
          
          
          
          
         