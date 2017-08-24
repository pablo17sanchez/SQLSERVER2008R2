


DECLARE @DIA INTEGER
DECLARE @FECHA DATE
SET @DIA = DATEPART(WEEKDAY,GETDATE()) 
SET @FECHA=GETDATE()
--SELECT @DIA
--SELECT @FECHA

--Insertar encabezado de ruta

INSERT INTO [DataRS].[dbo].[GP_RUTA_VH]
           ([NOMBRERUTA]
           ,[PALMID]
           ,[IDVENDEDOR]
           ,[TIPOVENDEDOR]
           ,[CodRuta])
    

SELECT NombreRuta,
       c.PALMID,
       R.IdVendedor,
       'VENDEDOR',
       CodRuta 
FROM PalmComSync..GP_RUTA R 
      INNER JOIN 
      PalmComSync..OUT_CONFIG c ON R.IdVendedor=c.IDVENDEDOR
WHERE PALMID LIKE 'GEA%' AND  NOT EXISTS (SELECT * FROM [DataRS].[dbo].[GP_RUTA_VH] WHERE FECHA=@FECHA)



INSERT INTO [DataRS].[dbo].[GP_CLIENTEDIASRUTA_VH]
           ([CodCliente]
           ,[Nombre]
           ,[CodRuta]
           ,[NombreRuta]
           ,[Lunes]
           ,[Martes]
           ,[Miercoles]
           ,[Jueves]
           ,[Viernes]
           ,[Sabado]
           ,[Domingo]
           ,[TIPOVENDEDOR])
    
 



SELECT [CodCliente]
           ,[Nombre]
           ,[CodRuta]
           ,[NombreRuta]
           ,[Lunes]
           ,[Martes]
           ,[Miercoles]
           ,[Jueves]
           ,[Viernes]
           ,[Sabado]
           ,[Domingo]
            
           ,'VENDEDOR' 
FROM PalmComSync..GP_CLIENTEDIASRUTA
WHERE CASE @DIA 
				 WHEN 1 THEN Domingo
				 WHEN 2 THEN Lunes
				 WHEN 3 THEN Martes 
				 WHEN 4 THEN Miercoles
				 WHEN 5 THEN Jueves
				 WHEN 6 THEN Viernes
				 WHEN 7 THEN Sabado END=1  AND NOT EXISTS (SELECT * FROM [DataRS].[dbo].[GP_CLIENTEDIASRUTA_VH] WHERE [DATE]=@FECHA)