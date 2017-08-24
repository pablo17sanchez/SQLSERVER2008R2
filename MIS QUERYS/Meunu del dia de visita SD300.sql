DECLARE @FECHA DATE
DECLARE @DIA INT
DECLARE @Query NVARCHAR(MAX)
DECLARE @Nombreruta NVARCHAR(50)
/*
SET @FECHA='20150807'
SET @DIA=DATEPART(WEEKDAY,@FECHA)
SET @Nombreruta='SD100-01'
--SELECT @DIA*/
SET @Query=N'
SELECT cg.CodCliente,
	   cg.Nombre, 
	   cg.NombreRuta,
	    CASE WHEN lvs.codclie='''' AND f.CODCLIE='''' THEN ''No visitado''
		     WHEN   lvs.codclie<> '''' THEN ''Visitado No facturado''
		     WHEN   f.codclie<> '''' THEN ''Visitado Facturado'' ELSE ''''
	  END as ''Estado''
	 FROM 
GP_CLIENTEDIASRUTA cg 
LEFT JOIN 
(		SELECT 
			CODCLIE,
			FECHA 
		FROM IN_LOGVISIT
		WHERE FECHA=CONVERT(DATE,@FECHA)
		GROUP BY 
			CODCLIE,
			FECHA 
		) lvs 
		ON cg.CodCliente=lvs.CODCLIE
LEFT JOIN 
(		SELECT 
			   CODCLIE,
			   FECHAFAC 
		FROM IN_FACTURA_TEMP
		WHERE FECHAFAC=CONVERT(DATE,@FECHA)
		GROUP BY 
			CODCLIE,
			FECHAFAC 
		) f 
		ON cg.CodCliente=f.CODCLIE
WHERE cg.NombreRuta=@Nombreruta '


IF @DIA=1
BEGIN
	SET @Query =@Query+'AND Domingo=1'
END 
IF @DIA=2 
BEGIN
	SET @Query =@Query+'AND Lunes=1'
END

IF @DIA=3
BEGIN
	SET @Query =@Query+'AND Martes=1'
END 
IF @DIA=4
BEGIN
	SET @Query =@Query+'AND Miercoles=1'
END 
IF @DIA=5
BEGIN
	SET @Query =@Query+'AND Jueves=1'
END 
IF @DIA=6
BEGIN
	SET @Query =@Query+'AND Viernes=1'
END 
IF @DIA=7
BEGIN
	SET @Query =@Query+'AND Sabado=1'
END 

--PRINT @Query

EXECUTE sp_executesql @Query, N'@FECHA DATE, @Nombreruta NVARCHAR(50)',@FECHA,@Nombreruta



  