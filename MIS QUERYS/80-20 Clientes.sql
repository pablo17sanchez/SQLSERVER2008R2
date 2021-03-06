  SELECT CUSTCLAS,v.CUSTNMBR,V.CUSTNAME, SUM(XTNDPRCE)'TOTAL' FROM GPHN..vw_VentasGP1 v INNER JOIN GPHN..RM00101 r ON v.CUSTNMBR=r.CUSTNMBR
  WHERE DOCDATE BETWEEN '20150101' AND '20151231' --AND v.LOCNCODE='SANISIDRO'
  GROUP BY CUSTCLAS,v.CUSTNMBR,V.CUSTNAME
  ORDER BY TOTAL DESC
  

  
  
  SELECT CUSTNMBR
		
		 
						
		
FROM GPHN..SVC00300  
WHERE Version<>'' AND OFFID='SD' AND  CUSTNMBR<>'ALASKA'
 GROUP BY CUSTNMBR
  
  SELECT a.CUSTNMBR,a.CATEGORIA,SUM(CANTIDAD)'CANTIDAD' FROM (
  SELECT CUSTNMBR,
		
		CASE WHEN ITEMNMBR LIKE 'A%' THEN 'ANAQUEL'
						WHEN ITEMNMBR LIKE 'BB%' THEN 'BEBEDERO'
						WHEN ITEMNMBR LIKE 'N%' THEN 'NEVERAS' 
						WHEN ITEMNMBR LIKE 'E%'  THEN 'EXHIBIDOR'
						WHEN ITEMNMBR LIKE '%PURA%' THEN 'RACK-PURA'
						WHEN ITEMNMBR LIKE '%KEEPRITE SC-288LP%' THEN 'EXHIBIDOR'
						ELSE 'OTROS' 
						END'CATEGORIA',
						COUNT(CUSTNMBR)'CANTIDAD'
						
		
FROM GPHN..SVC00300  
WHERE Version<>'' AND OFFID='SD' AND  CUSTNMBR<>'ALASKA'
GROUP BY CUSTNMBR,ITEMNMBR ) a

GROUP BY a.CUSTNMBR,a.CATEGORIA
ORDER BY a.CUSTNMBR
 
 
 
 
  SELECT CUSTCLAS,r.CUSTNMBR,r.CUSTNAME, ITEMNMBR,SUM(QUANTITY)'TOTAL', (CONVERT(DECIMAL(10,2),SUM(QUANTITY)/3))'PROMEDIO' FROM GPHN..vw_VentasGP1 v INNER JOIN GPHN..RM00101 r ON v.CUSTNMBR=r.CUSTNMBR
  WHERE DOCDATE BETWEEN '20150601' AND '20150831' AND v.LOCNCODE='SANISIDRO' --AND V.ITEMNMBR LIKE '%PT100%'
  GROUP BY CUSTCLAS,r.CUSTNMBR,r.CUSTNAME, ITEMNMBR
  ORDER BY TOTAL DESC
  
  
  
------Que no compraron que tiene equipo
   
SELECT DISTINCT r.CUSTCLAS, sv.CUSTNMBR,r.CUSTNAME, ISNULL(TOTAL,0)'TOTAL'
FROM GPHN..SVC00300 sv LEFT JOIN (  SELECT CUSTCLAS,v.CUSTNMBR,V.CUSTNAME, SUM(XTNDPRCE)'TOTAL' FROM GPHN..vw_VentasGP1 v INNER JOIN GPHN..RM00101 r ON v.CUSTNMBR=r.CUSTNMBR
  WHERE DOCDATE BETWEEN '20150601' AND '20150831' AND v.LOCNCODE='SANISIDRO'
  GROUP BY CUSTCLAS,v.CUSTNMBR,V.CUSTNAME
   ) v ON sv.CUSTNMBR=v.CUSTNMBR  LEFT JOIN GPHN..RM00101 R ON sv.CUSTNMBR=r.CUSTNMBR
WHERE OFFID ='SD' AND sv.CUSTNMBR<>'ALASKA' AND Version<>''-- AND ISNULL(TOTAL,0)=0

ORDER BY TOTAL DESC



SELECT * FROM GPHN..SVC00300  
WHERE CUSTNMBR IN (SELECT  sv.CUSTNMBR 
FROM GPHN..SVC00300 sv LEFT JOIN (  SELECT CUSTCLAS,v.CUSTNMBR,V.CUSTNAME, SUM(XTNDPRCE)'TOTAL' FROM GPHN..vw_VentasGP1 v INNER JOIN GPHN..RM00101 r ON v.CUSTNMBR=r.CUSTNMBR
  WHERE DOCDATE BETWEEN '20150601' AND '20150831' AND v.LOCNCODE='SANISIDRO'
  GROUP BY CUSTCLAS,v.CUSTNMBR,V.CUSTNAME
   ) v ON sv.CUSTNMBR=v.CUSTNMBR  INNER JOIN GPHN..RM00101 R ON sv.CUSTNMBR=r.CUSTNMBR
WHERE OFFID ='SD' AND sv.CUSTNMBR<>'ALASKA' AND Version<>'' AND ISNULL(TOTAL,0)=0

 )