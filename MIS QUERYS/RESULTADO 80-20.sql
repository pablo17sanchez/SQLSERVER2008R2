CREATE TABLE #TEMP14071991(
[FACTURA] VARCHAR(80),
NCF VARCHAR(80),
QUANTITY INT,
XTNDPRCE DECIMAL(18,2),
TIPO VARCHAR(20),
CUSTNAME VARCHAR(80),
CUSTNUMBR VARCHAR(80)
)




 
 
 INSERT INTO #TEMP14071991 ([FACTURA],NCF,QUANTITY,XTNDPRCE,TIPO,CUSTNAME,CUSTNUMBR)
 
 
SELECT 
	V.SOPNUMBE as [FACTURA],
	
	v.NCF,
	v.QUANTITY,
	v.XTNDPRCE,
SUBSTRING(v.NCF,10,2) as TIPO
		,v.CUSTNAME,v.CUSTNMBR
		FROM  [PS_vw_VentasGP2]   as v with(nolock)
WHERE v.DOCDATE BETWEEN '2016-01-01 00:00:00.000' AND '2016-12-31 00:00:00.000'  AND SOPNUMBE NOT IN (SELECT DOCNUMBR FROM GPHN.dbo.RM20101
WHERE BCHSOURC='Sales Entry' AND VOIDSTTS=1 AND DOCDATE BETWEEN '2016-01-01 00:00:00.000' AND '2016-12-31 00:00:00.000' AND RMDTYPAL=1) 







SELECT *
 FROM #TEMP14071991 where FACTURA    IN(SELECT FACTURA FROM #TEMP14071991 WHERE NCF<>'NULL' OR 
 NCF='                     ')
 
 
SELECT LEN('A010809940100003394') as A
  
  
  
   
   

   
   
   
   4982           
   
   
  
   order by IDLote desc
    SELECT IDAyudante, * FROM SITGPIntegration..TransaccionVenta where IDLote='4897-20170228'
