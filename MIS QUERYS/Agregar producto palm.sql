SELECT * FROM PalmComSync..OUT_PRODUCTO
WHERE PALMID='GEA059'

INSERT INTO [PalmComSync].[dbo].[OUT_PRODUCTO]
           ([PALMID]
           ,[CODPROD]
           ,[DESCRIP]
           ,[CATEGORIA]
           ,[COSTO]
           ,[PRECIO1]
           ,[PRECIO2]
           ,[PRECIO3]
           ,[EXISTENCIA]
           ,[INVENDIBLE]
           ,[GRAVABLE]
           ,[TAXID]
           ,[PRECMAX]
           ,[PRECMIN])

SELECT 'GEA059'
           ,[CODPROD]
           ,[DESCRIP]
           ,[CATEGORIA]
           ,[COSTO]
           ,[PRECIO1]
           ,[PRECIO2]
           ,[PRECIO3]
           ,[EXISTENCIA]
           ,[INVENDIBLE]
           ,[GRAVABLE]
           ,[TAXID]
           ,[PRECMAX]
           ,[PRECMIN] FROM PalmComSync..OUT_PRODUCTO
WHERE PALMID='GEA005'

