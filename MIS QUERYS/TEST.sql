USE SITGPIntegration
DELETE TransaccionVentaItem WHERE DescripcionProducto='N'
DELETE TransaccionVenta WHERE [Status]='N'
DELETE CargaGP WHERE Estatus='S'

select DOCID from GPHN..sop10100 group by DOCID

select * from SITGPIntegration..TransaccionVenta ORDER BY Fecha DESC


SELECT * FROM alaska_pcomdb..OUT_CON


delete  SITGPIntegration..TransaccionVenta WHERE [Status]='n'



SELECT * FROM PalmComSync..OUT_CLIENTES WHERE PALMID='GEA056'



UPDATE  alaska_pcomdb..OUT_SECUENCI SET PROXSEC='43'  WHERE PALMID='GEA037'AND TIPO='CND'



delete PalmComSync..IN_FACTURA_TEMP  where FACNUM in ('F0770005525  '
,'F0780005915      '
,'F0780005916      '
,'F0780005917      '
,'F0780005918      '
,'F1120005116      '
,'F1120005117      '
,'F0780005910      '
,'F0780005911      '
)



delete PalmComSync..IN_DETAFAC  where FACNUM in ('F0770005525  '
,'F0780005915      '
,'F0780005916      '
,'F0780005917      '
,'F0780005918      '
,'F1120005116      '
,'F1120005117      '
,'F0780005910      '
,'F0780005911      '
)






SELECT * FROM PalmComSync..OUT_CLIENTES WHERE PALMID='GEA018'

SELECT * FROM PalmComSync..OUT_CONFIG WHERE NOMBREVEND LIKE '%FERNA%'
select * from SITGPIntegration..RelacionConduce where NoDocumento='rc03244636'

