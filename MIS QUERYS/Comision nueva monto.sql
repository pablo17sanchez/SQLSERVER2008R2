 DECLARE @AFECHA DATETIME, 
	 @IFECHA DATETIME, 
	 @PROD NVARCHAR(15)

SET @AFECHA ='20160301'
SET @IFECHA='20160331'


SELECT 
       c.IdZona , 
        Rep.Responsable,
       c.IdClase, 
       CUSTNMBR,
       SOPNUMBE,
       v.ITEMNMBR,
       NombreRuta,
      -- p.PRECIO_ESTABLECIDO,
      -- p.Porciento,
      ((SUM(QUANTITY))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'CANTIDAD',
      ((SUM(XTNDPRCE))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'MONTO'
      
	  
      
FROM dbo.vw_VentasGPconConduceCA1 v 
	INNER JOIN  vw_Clientes_CSR c 
	ON RTRIM(v.CUSTNMBR)=RTRIM(c.CodCliente) 
	 /*INNER JOIN   (SELECT IdZona,PRECIO_ESTABLECIDO, Porciento,PROD FROM DataRS..GA_PARAMETROSMONTO
															 )p ON c.IdZona=p.Idzona AND v.ITEMNMBR=p.PROD */
	INNER JOIN ( SELECT    RTRIM(SALSTERR)'IdZona',RTRIM(RTRIM(STMGRFNM)+' '+RTRIM(STMGRLNM))'Responsable'
                            FROM          GPHN.dbo.RM00303
                           WHERE SALSTERR IN ('GA-01','GA-02','GA-03','GA-04','GA-05')
                            ) Rep ON RTRIM(c.IdZona)=RTRIM(Rep.IdZona)
WHERE    
   DOCDATE BETWEEN @AFECHA AND @IFECHA 
   AND DOCID NOT IN( 'A0100800101','A0100800115','A0100800114')  
   AND ITEMNMBR LIKE 'PT9%'
   AND NombreRuta LIKE 'SD[13]%' 
   AND UNITPRCE<>0
   AND c.IdClase<>'PUESTO DE VENTA'  AND LOCNCODE='SANISIDRO'
GROUP BY c.IdClase, 
         Rep.Responsable,
          CUSTNMBR,
          c.IdZona,
          SOPNUMBE,
          QUANTITY,
           NombreRuta,
          v.ITEMNMBR,
          XTNDPRCE --,
       --   p.PRECIO_ESTABLECIDO,
        --  p.Porciento
        ORDER BY SOPNUMBE
        



SELECT * FROM (

SELECT NOMBRERUTA,PALMID,IDVENDEDOR,FECHA,TIPOVENDEDOR FROM DataRS..GP_RUTA_S
UNION ALL
SELECT  NOMBRERUTA,PALMID,IDVENDEDOR,FECHA,TIPOVENDEDOR FROM DataRS..GP_RUTA_VH

) a WHERE FECHA='20160401' AND NOMBRERUTA LIKE '%SD%'
ORDER BY IDVENDEDOR

--***********Comision de vendedores montos ***************** /

SELECT DISTINCT r.IdZona , 
        r.ZonaResp Responsable,
       r1.CUSTCLAS IdClase, 
       r1.CUSTNMBR,
       SOPNUMBE,
       u.NombreRuta,
       --v.ITEMNMBR,
       ((SUM(QUANTITY))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'CANTIDAD',
      ((SUM(XTNDPRCE))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'MONTO'
FROM dbo.vw_VentasGPconConduceCA1 v 
INNER JOIN [DataRS].[dbo].[vw_encvendedorRuta] u ON v.IdVendedor= u.IDVENDEDOR AND v.DOCDATE=u.FECHA 
INNER JOIN PalmComSync..vw_RutaZona r ON u.NombreRuta=r.NombreRuta
INNER JOIN RM00101 r1 ON v.CUSTNMBR=r1.CUSTNMBR
WHERE DOCDATE BETWEEN '20160301' AND '20160331'  AND DOCID NOT IN( 'A0100800101','A0100800115','A0100800114')  AND UNITPRCE<>0
   AND r1.CUSTCLAS<>'PUESTO DE VENTA'  AND LOCNCODE='SANISIDRO'
   
AND u.NombreRuta LIKE 'SD[1]%' AND r.IdZona BETWEEN 'GA-01' AND 'GA-05' AND v.ITEMNMBR LIKE 'PT[1]%'
GROUP BY r.IdZona , 
        r.ZonaResp ,
       r1.CUSTCLAS  , 
       r1.CUSTNMBR,
       u.NombreRuta,
       SOPNUMBE,
       --v.ITEMNMBR,
       v.QUANTITY,
       v.XTNDPRCE
       
ORDER BY SOPNUMBE
 OPTION (MAXDOP 8)  


SELECT *
FROM dbo.vw_VentasGPconConduceCA1
WHERE DOCDATE BETWEEN '20160401' AND '20160401' AND IdVendedor<>''



SELECT IdZona,NombreRuta FROM PalmComSync..vw_RutaZona 
WHERE IdZona BETWEEN 'GA-01' AND 'GA-05'
GROUP BY IdZona,NombreRuta








SELECT DISTINCT r.IdZona , 
        r.ZonaResp Responsable,
       r1.CUSTCLAS IdClase, 
       r1.CUSTNMBR,
       SOPNUMBE,
       --v.ITEMNMBR,
       u.NombreRuta'HSRuta',
       r.NombreRuta,
       u.IDVENDEDOR'HSIDvend',
       r.IdVendedor,
       v.IdVendedor'VentIdvendedor',
       ((SUM(QUANTITY))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'CANTIDAD',
      ((SUM(XTNDPRCE))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'MONTO'
FROM dbo.vw_VentasGPconConduceCA1 v 
INNER JOIN DataRS..vw_ruta_sustitutos_vendedor_h u ON v.IdVendedor= u.IDVENDEDOR AND v.DOCDATE=u.FECHA 
INNER JOIN PalmComSync..vw_RutaZona r ON u.NombreRuta=r.NombreRuta
INNER JOIN RM00101 r1 ON v.CUSTNMBR=r1.CUSTNMBR
WHERE DOCDATE BETWEEN '20160401' AND '20160401' AND DOCID NOT IN( 'A0100800101','A0100800115','A0100800114')  AND UNITPRCE<>0
   AND r1.CUSTCLAS<>'PUESTO DE VENTA'  AND LOCNCODE='SANISIDRO'
   /*AND r.NombreRuta NOT IN ('SDADM-05',
'SDADM-08',
'SDADM-06',
'DELIVERY',
'SDADM-07',
'SC300-07'
) */ AND u.NombreRuta LIKE 'SD300%' AND r.IdZona BETWEEN 'GA-01' AND 'GA-05' AND v.ITEMNMBR='PT300'
GROUP BY r.IdZona , 
        r.ZonaResp ,
       r1.CUSTCLAS  , 
       r1.CUSTNMBR,
        r.NombreRuta,
       u.NombreRuta,
       SOPNUMBE,
       --v.ITEMNMBR,
       v.QUANTITY,
       v.XTNDPRCE,
       u.IDVENDEDOR ,
       r.IdVendedor,
       v.IdVendedor
       
ORDER BY SOPNUMBE



SELECT * FROM DataRS..vw_ruta_sustitutos_vendedor_h




SELECT ID,NOMBRERUTA,PALMID,IDVENDEDOR,FECHA,usuario,FECHAMODIF,TIPOVENDEDOR    
FROM         DataRS.dbo.GP_RUTA_S 
UNION ALL
SELECT ID,NOMBRERUTA,PALMID,IDVENDEDOR,FECHA,usuario,FECHAMODIF,TIPOVENDEDOR      
FROM                                 DataRS.dbo.GP_RUTA_VH 







---======================= Sin Historico

	SELECT 
       c.IdZona , 
        Rep.Responsable,
       c.IdClase, 
       CUSTNMBR,
       SOPNUMBE,
     --  p.PRECIO_ESTABLECIDO,
     --  p.Porciento,
      ((SUM(QUANTITY))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'CANTIDAD',
      ((SUM(XTNDPRCE))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'MONTO'
 
      
FROM dbo.vw_VentasGPconConduceCA1 v 
	INNER JOIN  vw_Clientes_CSR c 
	ON RTRIM(v.CUSTNMBR)=RTRIM(c.CodCliente) 
	
	INNER JOIN ( SELECT    RTRIM(SALSTERR)'IdZona',RTRIM(RTRIM(STMGRFNM)+' '+RTRIM(STMGRLNM))'Responsable'
                            FROM          GPHN.dbo.RM00303
                            WHERE SALSTERR IN ('GA-01','GA-02','GA-03','GA-04','GA-05')) Rep ON RTRIM(c.IdZona)=RTRIM(Rep.IdZona)
WHERE    
   DOCDATE BETWEEN '20160301' AND '20160331'
   AND DOCID NOT IN( 'A0100800101','A0100800115','A0100800114')  
   AND ITEMNMBR ='PT100' 
   AND NombreRuta LIKE 'SD100%' 
                        
   AND UNITPRCE<>0
   AND c.IdClase<>'PUESTO DE VENTA'  
GROUP BY c.IdClase, 
         Rep.Responsable,
          CUSTNMBR,
          c.IdZona,
          SOPNUMBE,
          QUANTITY,
          XTNDPRCE-- ,
        --  p.PRECIO_ESTABLECIDO,
       --   p.Porciento
       
       
       
       SELECT  DISTINCT v.*, c.NOMBRERUTA  FROM vw_VentasGPconConduceCA1 v INNER JOIN [DataRS].[dbo].[vw_encvendedorRuta]  c ON v.IdVendedor = c.IDVENDEDOR AND v.DOCDATE=c.FECHA
       WHERE SOPNUMBE IN ('F0400042603',         
'F0400042860' ,        
'F0400042889',          
'F0400042947',          
'F0400042784',          
'F0380040658',          
'F0380040857',          
'F0380040938'          
) AND ITEMNMBR='PT100' AND NOMBRERUTA LIKE 'SD100%'



SELECT * FROM PalmComSync..GP_CLIENTEDIASRUTA
WHERE CodCliente IN ('11334',


'34403',
'14704',
'33976'
)


SELECT * FROM PalmComSync..GP_RUTA
WHERE NombreRuta='SD300-15'