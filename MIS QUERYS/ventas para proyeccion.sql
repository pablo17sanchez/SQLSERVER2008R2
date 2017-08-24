 --RANCHERA
SELECT c.CUSTCLAS,DOCID, c.CUSTNMBR,c.CUSTNAME,SUM(QUANTITY)'CANT',SUM(XTNDPRCE)'MONTO',s.USERDEF1
FROM dbo.vw_VentasGPconConduceCA1 v INNER JOIN  RM00101 c ON RTRIM(v.CUSTNMBR)=RTRIM(c.CUSTNMBR) LEFT JOIN SOP10106 s ON v.SOPNUMBE=s.SOPNUMBE
WHERE   DOCDATE BETWEEN '20150101' AND '20151231' AND DOCID  NOT IN( 'A0100800101','A0100800115','A0100800114')  AND ITEMNMBR ='PT100' AND LOCNCODE='SANISIDRO' --AND NombreRuta is null
AND c.CUSTCLAS<>'PUESTO DE VENTA'  AND c.CUSTCLAS<>'DISTRIBUIDOR' AND UNITPRCE<>0
GROUP BY c.CUSTCLAS,DOCID, c.CUSTNMBR,c.CUSTNAME,s.USERDEF1

--PLANTA
SELECT c.CUSTNMBR,c.CUSTNAME,SUM(QUANTITY)'CANT',SUM(XTNDPRCE)'MONTO',s.USERDEF1
FROM dbo.vw_VentasGPconConduceCA1 v INNER JOIN  RM00101 c ON RTRIM(v.CUSTNMBR)=RTRIM(c.CUSTNMBR) LEFT JOIN SOP10106 s ON v.SOPNUMBE=s.SOPNUMBE
WHERE   DOCDATE BETWEEN '20150101' AND '20151231' AND DOCID   IN( 'A0100800101','A0100800115','A0100800114')  AND ITEMNMBR ='PT100' AND LOCNCODE='SANISIDRO' --AND NombreRuta is null
AND c.CUSTCLAS<>'PUESTO DE VENTA'  AND c.CUSTCLAS<>'DISTRIBUIDOR' AND UNITPRCE<>0
GROUP BY c.CUSTCLAS,DOCID, c.CUSTNMBR,c.CUSTNAME,s.USERDEF1


--PUESTO
SELECT c.CUSTCLAS,DOCID, c.CUSTNMBR,c.CUSTNAME,SUM(QUANTITY)'CANT',SUM(XTNDPRCE)'MONTO',s.USERDEF1
FROM dbo.vw_VentasGPconConduceCA1 v INNER JOIN  RM00101 c ON RTRIM(v.CUSTNMBR)=RTRIM(c.CUSTNMBR) LEFT JOIN SOP10106 s ON v.SOPNUMBE=s.SOPNUMBE
WHERE   DOCDATE BETWEEN '20150101' AND '20151231' --AND DOCID   IN( 'A0100800101','A0100800115','A0100800114')  
AND ITEMNMBR ='PT100' AND LOCNCODE='SANISIDRO' --AND NombreRuta is null
AND c.CUSTCLAS='PUESTO DE VENTA'  --AND c.CUSTCLAS<>'DISTRIBUIDOR' 
AND UNITPRCE<>0
GROUP BY c.CUSTCLAS,DOCID, c.CUSTNMBR,c.CUSTNAME,s.USERDEF1

--DISTRIBUIDOR
SELECT c.CUSTCLAS,DOCID, c.CUSTNMBR,c.CUSTNAME,SUM(QUANTITY)'CANT',SUM(XTNDPRCE)'MONTO',s.USERDEF1
FROM dbo.vw_VentasGPconConduceCA1 v INNER JOIN  RM00101 c ON RTRIM(v.CUSTNMBR)=RTRIM(c.CUSTNMBR) LEFT JOIN SOP10106 s ON v.SOPNUMBE=s.SOPNUMBE
WHERE   DOCDATE BETWEEN '20150101' AND '20151231' --AND DOCID   IN( 'A0100800101','A0100800115','A0100800114')  
AND ITEMNMBR ='PT100' AND LOCNCODE='SANISIDRO' --AND NombreRuta is null
AND c.CUSTCLAS='DISTRIBUIDOR'  --AND c.CUSTCLAS<>'DISTRIBUIDOR' 
AND UNITPRCE<>0
GROUP BY c.CUSTCLAS,DOCID, c.CUSTNMBR,c.CUSTNAME,s.USERDEF1
--PROMO
SELECT  c.CUSTNMBR
FROM dbo.vw_VentasGPconConduceCA1 v INNER JOIN  RM00101 c ON RTRIM(v.CUSTNMBR)=RTRIM(c.CUSTNMBR) LEFT JOIN SOP10106 s ON v.SOPNUMBE=s.SOPNUMBE
WHERE   DOCDATE BETWEEN '20150101' AND '20151231' --AND DOCID   IN( 'A0100800101','A0100800115','A0100800114')  
AND ITEMNMBR ='PT100' AND LOCNCODE='SANISIDRO' --AND NombreRuta is null
--AND c.CUSTCLAS='DISTRIBUIDOR'  --AND c.CUSTCLAS<>'DISTRIBUIDOR' 
AND UNITPRCE=0
GROUP BY c.CUSTNMBR


SELECT COUNT(CodCliente) FROM PalmComSync..GP_CLIENTEDIASRUTA
WHERE NombreRuta LIKE 'SD100%'