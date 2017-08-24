DECLARE @LOCALIDAD VARCHAR(50),
        @PROD VARCHAR(50),
        @IFECHA DATE,
        @AFECHA DATE
        
SET @LOCALIDAD='SANISIDRO'
SET @PROD='PT100'
SET @IFECHA='20141101'
SET @AFECHA='20141101'



SELECT  --s.NombreSupervisor,s.NombreRuta, 
       CUSTNMBR,
     
       QUANTITY,
       LOCNCODE,
       ITEMNMBR,
       R.IdVendedor,
       r.NombreSupervisor,r.NombreRuta
       
    FROM vw_VentasGP1 v  LEFT JOIN vw_Ruta_Clientes R  ON RTRIM(v.CUSTNMBR)=RTRIM(R.CodCliente)  
WHERE  LOCNCODE=@LOCALIDAD AND ITEMNMBR=@PROD AND 
  R.NombreRuta  LIKE '%SD100%' AND DOCDATE BETWEEN @IFECHA AND @AFECHA
                     
GROUP BY R.NombreRuta,
LOCNCODE, CUSTNMBR,ITEMNMBR,QUANTITY,
       LOCNCODE,
       ITEMNMBR, R.IdVendedor,
       r.NombreSupervisor,r.NombreRuta
     
       
       
 SELECT * FROM [GPHN].[dbo].[vw_VentasGPconConduceCA] 
   WHERE DOCDATE BETWEEN '20141101' AND '20141101' AND LOCNCODE='SANISIDRO' AND  ITEMNMBR='PT100' AND 
RTRIM(NombreRuta) LIKE CASE WHEN @PROD='PT100' AND @LOCALIDAD='SANISIDRO' THEN '%SD1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='SANISIDRO' THEN '%SD3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='ROMANA' THEN '%RO1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='ROMANA' THEN '%RO3%' 
                       WHEN @PROD='PT100' AND @LOCALIDAD='BAVARO' THEN '%BA1%'
                       WHEN @PROD='PT300' AND @LOCALIDAD='BAVARO' THEN '%BA3%' 
                       END
       
   
 /*  SELECT * FROM [GPHN].[dbo].[vw_VentasGPconConduceCA] 
   WHERE DOCDATE BETWEEN '20141101' AND '20141110' AND LOCNCODE='SANISIDRO'*/
 /*  SELECT * FROM PalmComSync.dbo.vw_gp_ClienteDiasRutaZona
   */
   
   SELECT * FROM PalmComSync..GP_CLIENTEDIASRUTA
   WHERE CodCliente='21886'
   
   SELECT v.CUSTNMBR,
		  v.CUSTNAME,
		  v.ITEMNMBR,
		  v.QUANTITY,
		  s.ITEMNMBR'ACTIVOS',
		 
		  ISNULL(r.NombreRuta,'N/A')'RUTA',
		  r.NombreSupervisor,
		  r.ZonaResp
   FROM vw_VentasGP1 v LEFT JOIN SVC00300 s ON v.CUSTNMBR=s.CUSTNMBR LEFT JOIN PalmComSync..vw_gp_ClienteDiasRutaZona r ON v.CUSTNMBR=r.CodCliente
   WHERE v.DOCDATE BETWEEN @IFECHA AND @AFECHA AND v.ITEMNMBR=@PROD AND LOCNCODE=@LOCALIDAD 
   GROUP BY v.CUSTNMBR,v.CUSTNAME,v.ITEMNMBR,v.QUANTITY,s.ITEMNMBR,r.NombreRuta,r.NombreSupervisor, r.ZonaResp
   ORDER BY v.CUSTNMBR
   
   
   SELECT * FROM vw_Ruta_Clientes
   WHERE CodCliente IN (SELECT CUSTNMBR FROM vw_VentasGP1 WHERE  LOCNCODE='BAVARO')
   
   
   
      SELECT * FROM RM00101
   WHERE CUSTNMBR IN (SELECT CUSTNMBR FROM vw_VentasGP1 WHERE DOCDATE <= '20160623' AND LOCNCODE='BAVARO') AND HOLD=0