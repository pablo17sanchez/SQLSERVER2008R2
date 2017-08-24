DECLARE @FECHA DATE
DECLARE @DIA INT
DECLARE @Query NVARCHAR(MAX)
DECLARE @Nombreruta NVARCHAR(50)

SET @FECHA='20150824'
SET @DIA=DATEPART(WEEKDAY,@FECHA)
SET @Nombreruta='SD300-15'


SELECT cg.CodCliente,
	   cg.Nombre, 
	   cg.NombreRuta,
	    CASE WHEN lvs.CodCliente='' AND f.CODCLIE='' THEN 'No visitado'
		     WHEN   lvs.CodCliente<> '' AND lvs.NombreRuta=@Nombreruta THEN 'Visitado No facturado'
		     WHEN   f.codclie<> '' THEN 'Visitado Facturado' ELSE ''
	  END as 'Estado'
	 FROM 
GP_CLIENTEDIASRUTA cg 
LEFT JOIN 
(		SELECT 
			NombreRuta,
			CodCliente,
			FECHA 
		FROM  dbo.vw_logvisitasruta
		WHERE FECHA=CONVERT(DATE,@FECHA) AND NombreRuta=@Nombreruta
		GROUP BY 
			NombreRuta,
			CodCliente,
			FECHA 
		) lvs 
		ON cg.CodCliente=lvs.CodCliente --AND cg.NombreRuta=lvs.NombreRuta
LEFT JOIN 
(		SELECT 
			   CODCLIE,
			   FECHAFAC 
		FROM IN_FACTURA_TEMP F INNER JOIN IN_DETAFAC D ON F.FACNUM=D.FACNUM
		WHERE FECHAFAC=CONVERT(DATE,@FECHA) AND  D.CODPROD  LIKE CASE WHEN @Nombreruta LIKE '_30%' THEN  '%PT300%'
																	  WHEN @Nombreruta LIKE '_10%' THEN  '%PT100%'
																	  WHEN @Nombreruta LIKE '_90%'    THEN '%PT90%'
																	  END
		GROUP BY 
			CODCLIE,
			FECHAFAC 
		) f 
		ON cg.CodCliente=f.CODCLIE
WHERE cg.NombreRuta=@Nombreruta AND Lunes=1
ORDER BY cg.CodCliente



---10269 SD100-07 Lunes y Miercoles  SD300-07 Sabado --20150815--> PT300 20150818-->PT100      