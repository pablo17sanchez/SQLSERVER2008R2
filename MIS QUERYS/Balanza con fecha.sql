DECLARE @fecha DATETIME
SET @fecha='20151106'

select
CM.CUSTNMBR Cod_cliente, 
CM.CUSTNAME Nombre_cliente,

sum(case
when  RM.RMDTYPAL < 7 AND DATEDIFF(d, RM.DOCDATE, @fecha) <31    THEN RM.CURTRXAM
when  RM.RMDTYPAL > 6 AND RM.AGNGBUKT=1 then RM.CURTRXAM *-1
else 0
end) [menor_30],
 
sum(case
when RM.RMDTYPAL < 7 AND DATEDIFF(d, RM.DOCDATE,@fecha) between 31 and 60 then RM.CURTRXAM
 
else 0
end) [31_a_60_Dias],
 
sum(case
when RM.RMDTYPAL < 7 AND DATEDIFF(d, RM.DOCDATE, @fecha) between 61 and 90 then RM.CURTRXAM

else 0
end) [61_a_90_Dias],
 
sum(case
when RM.RMDTYPAL < 7 AND DATEDIFF(d, RM.DOCDATE, @fecha) between 91 and 120 then RM.CURTRXAM

else 0
end) [91_a_120_Dias],
 sum(case
when RM.RMDTYPAL < 7 AND DATEDIFF(d, RM.DOCDATE, @fecha) between 121 and 150 then RM.CURTRXAM
else 0
end) [121_a_150_Dias],

 sum(case
when RM.RMDTYPAL < 7 AND DATEDIFF(d, RM.DOCDATE, @fecha) between 151 and 180 then RM.CURTRXAM
else 0
end) [151_a_180_Dias],

 sum(case
when RM.RMDTYPAL < 7 AND DATEDIFF(d, RM.DOCDATE, @fecha) >180 then RM.CURTRXAM
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
LEFT join RM00103 CS
     on RM.CUSTNMBR = CS.CUSTNMBR
LEFT JOIN CN00500 CN ON RM.CUSTNMBR=CN.CUSTNMBR
where RM.VOIDSTTS = 0 and RM.CURTRXAM <> 0 
--AND RM.CUSTNMBR NOT LIKE 'C%' 
AND RM.DOCDATE<=@fecha 
--AND CM.CUSTCLAS IN (@clase)  
 
group by CM.CUSTNMBR, CM.CUSTNAME, CM.PYMTRMID, CM.CUSTCLAS, 
         CM.CRLMTAMT, CS.LASTPYDT,CS.LPYMTAMT,CN.CRDTMGR,CM.SALSTERR
   HAVING   sum(case
when RM.RMDTYPAL < 7 then RM.CURTRXAM
else RM.CURTRXAM * -1
end) >0       
ORDER BY CM.CUSTNMBR



--16827          
SELECT * FROM RM00101
WHERE CUSTNMBR='CORP0051'