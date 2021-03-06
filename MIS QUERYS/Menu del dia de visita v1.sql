USE [GPHN]
GO
/****** Object:  StoredProcedure [dbo].[spc_menudevisita]    Script Date: 09/01/2015 09:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Kelvin Mendoza>
-- Create date: <Create Date,,>
-- Description:	<Menu de visitas>
-- =============================================
 ALTER PROCEDURE [dbo].[spc_menudevisita]
	-- Add the parameters for the stored procedure here
	 @FECHA DATE,
     @Nombreruta NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    DECLARE @DIA INT
    DECLARE @Query NVARCHAR(MAX)
    
    SET @DIA=DATEPART(WEEKDAY,@FECHA)
    -- Insert statements for procedure here
    
    SET @Query=N'
SELECT cg.CodCliente,
	   cg.Nombre, 
	   cg.NombreRuta,
	    CASE WHEN lvs.codclie='''' AND f.CODCLIE='''' THEN ''No visitado''
		     WHEN   lvs.codclie<> '''' THEN ''Visitado No facturado''
		     WHEN   f.codclie<> '''' THEN ''Visitado Facturado'' ELSE ''''
	  END as ''Estado''
	 FROM 
Palmcomsync..GP_CLIENTEDIASRUTA cg 
LEFT JOIN 
(		SELECT 
			CODCLIE,
			FECHA 
		FROM Palmcomsync..IN_LOGVISIT
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
		FROM Palmcomsync..IN_FACTURA_TEMP
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
	
END
