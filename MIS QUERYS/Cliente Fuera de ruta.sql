SELECT [GPHN].[dbo].[fn_ClienteFueraDeldia] (
   '20160314'
  ,'1023'
  ,'PT100')
GO



SELECT DATEPART(WEEKDAY,'20160314')

 SELECT *
	FROM PalmComSync..IN_FACTURA_TEMP WHERE CODCLIE IN (
SELECT CodCliente FROM PalmComSync..GP_CLIENTEDIASRUTA
WHERE CodCliente IN (
SELECT CODCLIE FROM PalmComSync..IN_FACTURA_TEMP
WHERE FECHAFAC='20160314' AND idvendedor='1023') AND NombreRuta LIKE   'SD1%'
                                                        AND CASE DATEPART(WEEKDAY,'20160314') WHEN 1 THEN Domingo 
                                    WHEN 2 THEN Lunes 
                                    WHEN 3 THEN Martes
                                    WHEN 4 THEN Miercoles
                                    WHEN 5 THEN Jueves
                                    WHEN 6 THEN Viernes
                                    WHEN 7 THEN Sabado END<>1
                                    
                                    
                                    ) AND FECHAFAC='20160314'

ORDER BY QUERY
