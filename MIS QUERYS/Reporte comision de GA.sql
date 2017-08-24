DECLARE @AFECHA DATETIME, @IFECHA DATETIME, @PROD NVARCHAR(15)

SET @AFECHA='20151201'
SET @IFECHA='20151208'
SET @PROD='PT300'


SELECT 
       c.IdZona , 
       c.IdClase, 
       CUSTNMBR,
       SOPNUMBE,
       p.PRECIO_ESTABLECIDO,
       p.Porciento,
      ((SUM(QUANTITY))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'CANTIDAD',
      ((SUM(XTNDPRCE))/COUNT(*))/ COUNT(SOPNUMBE)OVER (PARTITION BY SOPNUMBE)'MONTO'
 
      
FROM dbo.vw_VentasGPconConduceCA1 v 
	INNER JOIN  vw_Clientes_CSR c 
	ON RTRIM(v.CUSTNMBR)=RTRIM(c.CodCliente) 
	INNER JOIN   (SELECT IdZona,PRECIO_ESTABLECIDO, Porciento,PROD FROM DataRS..GA_PARAMETROS
															 )p ON c.IdZona=p.Idzona AND v.ITEMNMBR=p.PROD
WHERE    
   DOCDATE BETWEEN @AFECHA AND @IFECHA 
   AND DOCID NOT IN( 'A0100800101','A0100800115','A0100800114')  
   AND ITEMNMBR =@PROD 
   AND NombreRuta LIKE  CASE 
                        WHEN @PROD='PT300' THEN '%SD300%'
                        WHEN @PROD='PT100' THEN '%SD100%' 
                        END 
   AND UNITPRCE<>0
   AND c.IdClase<>'PUESTO DE VENTA'  
GROUP BY c.IdClase,  
          CUSTNMBR,
          c.IdZona,
          SOPNUMBE,
          QUANTITY,
          XTNDPRCE,
          p.PRECIO_ESTABLECIDO,
          p.Porciento