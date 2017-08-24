   DECLARE @LOCALIDAD VARCHAR(50),
        @PROD VARCHAR(50),
        @IFECHA DATE,
        @AFECHA DATE
        
SET @LOCALIDAD='SANISIDRO'
SET @PROD='PT100'
SET @IFECHA='20141101'
SET @AFECHA='20141101'
   
   SELECT v.CUSTNMBR,
		  v.CUSTNAME,
		  v.ITEMNMBR,
		  v.QUANTITY,
		  s.ITEMNMBR'ACTIVOS',
		  A.CANT_ACT,
		  B.CANT_ACT'CANT_TOTAL',
		  ISNULL(r.NombreRuta,'N/A')'RUTA',
		  r.NombreSupervisor,
		  r.ZonaResp
   FROM (  SELECT 
			CUSTNMBR,
		    CUSTNAME,
		    ITEMNMBR,
			SUM(QUANTITY)'QUANTITY'
		 
			FROM vw_VentasGP1 
   WHERE DOCDATE BETWEEN @IFECHA AND @AFECHA AND ITEMNMBR=@PROD AND LOCNCODE=@LOCALIDAD 
   GROUP BY CUSTNMBR,
		    CUSTNAME,
		    ITEMNMBR ) v LEFT JOIN SVC00300 s ON v.CUSTNMBR=s.CUSTNMBR 
                       LEFT JOIN PalmComSync..vw_gp_ClienteDiasRutaZona r ON v.CUSTNMBR=r.CodCliente
                       LEFT JOIN  
                       (SELECT CUSTNMBR,
							   ITEMNMBR,
                               COUNT(ITEMNMBR)'CANT_ACT'
         
						FROM SVC00300 
						WHERE CUSTNMBR IN (SELECT CUSTNMBR
													FROM vw_VentasGP1
												WHERE DOCDATE BETWEEN @IFECHA AND @AFECHA  
												                              AND ITEMNMBR=@PROD  
												                              AND LOCNCODE=@LOCALIDAD   )
                                              GROUP BY CUSTNMBR,ITEMNMBR) A 
                                             ON v.CUSTNMBR=A.CUSTNMBR AND s.ITEMNMBR=A.ITEMNMBR
					  LEFT JOIN 
					  (SELECT CUSTNMBR,
						      COUNT(ITEMNMBR)'CANT_ACT'
             				  FROM SVC00300 
							  WHERE CUSTNMBR IN (SELECT CUSTNMBR
														FROM vw_VentasGP1
													WHERE DOCDATE BETWEEN @IFECHA 
																		  AND @AFECHA  
													                      AND ITEMNMBR=@PROD  
													                      AND LOCNCODE=@LOCALIDAD   )
							GROUP BY CUSTNMBR
   ) B ON v.CUSTNMBR=B.CUSTNMBR
   --WHERE --v.DOCDATE BETWEEN @IFECHA AND @AFECHA AND v.ITEMNMBR=@PROD AND LOCNCODE=@LOCALIDAD 
   GROUP BY v.CUSTNMBR,
		  v.CUSTNAME,
		  v.ITEMNMBR,
		  v.QUANTITY,
		  s.ITEMNMBR,
		  A.CANT_ACT,
		  B.CANT_ACT,
		  r.NombreRuta,
		  r.NombreSupervisor,
		  r.ZonaResp
   ORDER BY v.CUSTNMBR
   
   
  /* (SELECT CUSTNMBR,
           
  
           COUNT(ITEMNMBR)'CANT_ACT'
         
   FROM SVC00300 
   WHERE CUSTNMBR IN (SELECT CUSTNMBR
		              FROM vw_VentasGP1
		              WHERE DOCDATE BETWEEN '20141001' AND '20141030' AND ITEMNMBR='PT100' AND LOCNCODE='BAVARO'  )--AND CUSTNMBR='11162'
   GROUP BY CUSTNMBR)
         
   
  SELECT * FROM RM00101
   WHERE HOLD=0 AND INACTIVE=0 AND USERDEF1 LIKE '%ESPECIAL%'--TAXSCHID=''*/
   
   
      SELECT 
			CUSTNMBR,
		    CUSTNAME,
		    ITEMNMBR,
			SUM(QUANTITY)'QUANTITY'
		 
   FROM vw_VentasGP1 
   WHERE DOCDATE BETWEEN @IFECHA AND @AFECHA AND ITEMNMBR=@PROD AND LOCNCODE=@LOCALIDAD 
   GROUP BY CUSTNMBR,
		    CUSTNAME,
		    ITEMNMBR
		    
		    
		    SELECT * FROM SY03900
		   
		    SELECT * FROM PM30200
		    SELECT * FROM PM10300
		    
		    SELECT * FROM PM00200
		    SELECT * FROM MC020105
		    
		   