

select  HEADER.SOPNUMBE,HEADER.DOCDATE,DETAIL.USRDEF05 AS NCF,HEADER.CUSTNMBR,HEADER.CUSTNAME,CASE WHEN HEADER.VOIDSTTS=1 THEN 'NULO' ELSE 'NO ESTA NULO' END FROM  GPHN..SOP30200 AS HEADER LEFT JOIN GPHN..SOP10106 AS 
DETAIL ON HEADER.SOPNUMBE=DETAIL.SOPNUMBE
WHERE DETAIL.USRDEF05 IN (SELECT USRDEF05 FROM GPHN..SOP10106 AS DETAIL LEFT JOIN GPHN..SOP30200 AS HEADER ON DETAIL.SOPNUMBE=HEADER.SOPNUMBE
 WHERE USRDEF05 LIKE '%A0100800801000%'  AND  HEADER.DOCDATE>='2016-10-01 00:00:00.000' GROUP BY USRDEF05 HAVING COUNT(*)>1)
and  DOCDATE>='2016-10-01 00:00:00.000' 

UNION ALL


select HEADER.SOPNUMBE,HEADER.DOCDATE,DETAIL.USRDEF05 AS NCF,HEADER.CUSTNMBR,HEADER.CUSTNAME,CASE WHEN HEADER.VOIDSTTS=1 THEN 'NULO' ELSE 'NO ESTA NULO' END from GPHN..SOP10100 AS HEADER LEFT JOIN GPHN..SOP10106 AS 
DETAIL ON HEADER.SOPNUMBE=DETAIL.SOPNUMBE
WHERE DETAIL.USRDEF05 IN (SELECT USRDEF05 FROM GPHN..SOP10106 AS DETAIL LEFT JOIN GPHN..SOP30200 AS HEADER ON DETAIL.SOPNUMBE=HEADER.SOPNUMBE
 WHERE USRDEF05 LIKE '%A0100800801000%'  AND  HEADER.DOCDATE>='2016-10-01 00:00:00.000' GROUP BY USRDEF05 HAVING COUNT(*)>1
 
) and DOCDATE>='2016-10-01 00:00:00.000'

order by NCF







