USE [GPHN]
GO
/****** Object:  Trigger [dbo].[tr_update_SOP10100]    Script Date: 11/01/2010 14:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[tr_update_SOP10100]
   ON  [dbo].[SOP10100]
   AFTER UPDATE, INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    declare @ruta as varchar(20), @sopnumbe  as varchar(20), @vendedor as varchar(16),@soptype as int
        
    DECLARE inserted_cursor CURSOR FOR 
    select sopnumbe, soptype from inserted
    
    OPEN inserted_cursor
    FETCH NEXT FROM inserted_cursor INTO @sopnumbe, @soptype

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    select top 1 @vendedor = slprsnid
		from (select SLPRSNID from sop10100 s1 where s1.SOPNUMBE=@sopnumbe and s1.SOPTYPE=@soptype
		  UNION ALL select slprsnid from SOP30200 s2 where s2.SOPNUMBE=@sopnumbe and s2.SOPTYPE=@soptype) s

		select top 1 @ruta = r.NombreRuta 
		from palmcomsync..GP_CLIENTEDIASRUTA cr right join PalmComSync..gp_ruta r on (cr.CodRuta=r.CodRuta)
		where CodStatus =1 and IdVendedor = @vendedor
		order by codcliente

		IF (RTRIM(ISNULL((SELECT USERDEF1 FROM SOP10106 where SOPNUMBE=@sopnumbe and SOPTYPE = @soptype),''))='')
			update SOP10106
			set USERDEF1 = ISNULL(@ruta,'NO HAY RUTA - ' + @vendedor)
			where SOPNUMBE=@sopnumbe and SOPTYPE = @soptype

		FETCH NEXT FROM inserted_cursor INTO @sopnumbe, @soptype
	END
	CLOSE inserted_cursor
	DEALLOCATE inserted_cursor
END
