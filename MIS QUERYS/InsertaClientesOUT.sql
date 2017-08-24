use palmcomsync


DELETE from out_clientes 

insert into out_clientes 
(BALANCE,CEDULA,CODCLIE,LIMCRED,NOMBRE,PALMID,RUTA,SECTOR,STATUS,TELEFONO1,TELEFONO2)
SELECT [Balance]
      ,CEDULA
     
      ,CAST([COD_CLIENTE]AS NVARCHAR(5)) AS COD_CLIENTE
      ,[LIMCRED]
      ,CAST([NOMBRE]AS NVARCHAR(50))AS NOMBRE
	 
      ,[PALMID]
      ,[RUTA]
      ,[SECTOR]
      ,[estatus]
      ,[TEL1]
      ,[TEL2]
     
  FROM [PalmComSync].[dbo].[vw_Clientes_Palm]

SELECT *  from out_clientes 
