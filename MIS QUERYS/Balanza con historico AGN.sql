DECLARE @fecha DATETIME
SET @fecha='20151105'

select
CM.CUSTNMBR Cod_cliente, 
CM.CUSTNAME Nombre_cliente,

sum(case
when  RM.RMDTYPAL < 7 AND RM.AGNGBUKT=1  THEN RM.CURTRXAM
when  RM.RMDTYPAL > 6 AND RM.AGNGBUKT=1 then RM.CURTRXAM *-1
else 0
end) [menor_30],
 
sum(case
when RM.RMDTYPAL < 7 AND RM.AGNGBUKT=2 then RM.CURTRXAM
when   RM.AGNGBUKT=2
     and RM.RMDTYPAL > 6 then RM.CURTRXAM * -1
else 0
end) [31_a_60_Dias],
 
sum(case
when RM.AGNGBUKT=3
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when RM.AGNGBUKT=3
     and RM.RMDTYPAL > 6 then RM.CURTRXAM * -1
else 0
end) [61_a_90_Dias],
 
sum(case
when RM.AGNGBUKT=4
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when RM.AGNGBUKT=4
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [91_a_120_Dias],
 sum(case
when RM.AGNGBUKT=5
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when RM.AGNGBUKT=5
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [121_a_150_Dias],

 sum(case
when RM.AGNGBUKT=6
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when RM.AGNGBUKT=6
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [151_a_180_Dias],

 sum(case
when RM.AGNGBUKT>6
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when RM.AGNGBUKT>6
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [181_y_mas],

sum(case
when RM.RMDTYPAL < 7 then RM.CURTRXAM
else RM.CURTRXAM * -1
end) Saldo,
CM.CRLMTAMT Limite_actual,
CM.CUSTCLAS Clases,
ISNULL(CN.CRDTMGR,'') GESTORA,
CASE CM.SALSTERR WHEN 'GA-12' THEN 'BAVARO'
				 WHEN 'GA-13' THEN 'ROMANA'
				 WHEN 'GA-01' THEN 'SAN ISIDRO'
				 WHEN 'GA-02' THEN 'SAN ISIDRO'
				 WHEN 'GA-03' THEN 'SAN ISIDRO'
				 WHEN 'GA-04' THEN 'SAN ISIDRO'
				 WHEN 'GA-05' THEN 'SAN ISIDRO'
				 WHEN 'GA-06' THEN 'SAN ISIDRO'
				 WHEN 'GA-07' THEN 'SAN ISIDRO'
				 WHEN 'GA-08' THEN 'SAN ISIDRO'
				 WHEN 'GA-09' THEN 'SAN ISIDRO'
				 WHEN 'GA-10' THEN 'SAN ISIDRO'
				 WHEN 'GA-11' THEN 'SAN ISIDRO'
				 ELSE ' ' END Localidad,
CS.LASTPYDT Fecha_ultimo_pago,
CS.LPYMTAMT Ultimo_monto_pagado
 
from RM20101 RM
 
inner join RM00101 CM
     on RM.CUSTNMBR = CM.CUSTNMBR
inner join RM00103 CS
     on RM.CUSTNMBR = CS.CUSTNMBR
LEFT JOIN CN00500 CN ON RM.CUSTNMBR=CN.CUSTNMBR
where RM.VOIDSTTS = 0 and RM.CURTRXAM <> 0 --AND RM.CUSTNMBR NOT LIKE 'C%' 
--AND RM.DOCDATE<=@fecha 
--AND CM.CUSTCLAS IN (@clase)  
 
group by CM.CUSTNMBR, CM.CUSTNAME, CM.PYMTRMID, CM.CUSTCLAS, 
         CM.CRLMTAMT, CS.LASTPYDT,CS.LPYMTAMT,CN.CRDTMGR,CM.SALSTERR
   HAVING   sum(case
when RM.RMDTYPAL < 7 then RM.CURTRXAM
else RM.CURTRXAM * -1
end) >0       
ORDER BY CM.CUSTNMBR


SELECT AGNGBUKT,DATEDIFF(d,  DUEDATE, '20151102'),CURTRXAM*-1,* FROM RM20101
WHERE CUSTNMBR='11250' AND --DOCNUMBR='803-233894' AND 
CURTRXAM<>0
AND
DATEDIFF(d,  DOCDATE, '20151102') =4557


SELECT * FROM dbo.RM00103
WHERE CUSTNMBR='11257'


SELECT AGNGBUKT,RMDTYPAL FROM RM20101
WHERE RMDTYPAL>6 AND CURTRXAM<>0
GROUP BY AGNGBUKT,RMDTYPAL



SELECT AGNGBUKT,RMDTYPAL FROM RM20101
WHERE RMDTYPAL<6 AND CURTRXAM<>0
GROUP BY AGNGBUKT,RMDTYPAL

SELECT DOCNUMBR,RMDTYPAL ,AGNGBUKT,DATEDIFF(d,  DUEDATE, '20151103'),CURTRXAM*-1FROM RM20101
WHERE   CURTRXAM<>0 AND CUSTNMBR='11268'
--GROUP BY AGNGBUKT,RMDTYPAL