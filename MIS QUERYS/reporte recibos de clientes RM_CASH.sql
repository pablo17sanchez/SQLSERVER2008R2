SELECT RM.CUSTNMBR'Número de cliente',
		  CUSTNAME'Nombre de cliente',
		  CUSTCLAS'Clase de cliente',
		  DOCNUMBR'Número de documento',
		  ORTRXAMT'Monto Documento',
		  'Pagos' as 'Tipo de documento',
		  DOCDATE'Fecha del documento',
		  BACHNUMB'Número de lote',
		  CASE ONHOLD WHEN 0 THEN '' 
					  ELSE '' END 'Estado del documento',
		  '' AS 'Id. usuario contabilizado',
		  LSTUSRED'Último usuario para editar',
		  BCHSOURC'Origen del lote'
		  
FROM RM10201 RM INNER JOIN RM00101 RM1 ON RM.CUSTNMBR=RM1.CUSTNMBR
WHERE DOCDATE BETWEEN '20150216' AND '20150315' AND CUSTCLAS <>'VENDEDOR' AND BCHSOURC NOT LIKE '%Sales%'
AND RMDTYPAL=9
UNION ALL
SELECT RM.CUSTNMBR'Número de cliente',
		  CUSTNAME'Nombre de cliente',
		  CUSTCLAS'Clase de cliente',
		  DOCNUMBR'Número de documento',
		  ORTRXAMT'Monto Documento',
		  'Pagos' as 'Tipo de documento',
		  DOCDATE'Fecha del documento',
		  BACHNUMB'Número de lote',
		  CASE VOIDSTTS WHEN 0 THEN 'Normal' 
					  ELSE 'Anulado' END 'Estado del documento',
		  PSTUSRID AS 'Id. usuario contabilizado',
		  LSTUSRED'Último usuario para editar',
		  BCHSOURC'Origen del lote' 
		  FROM RM20101 RM INNER JOIN RM00101 RM1 ON RM.CUSTNMBR=RM1.CUSTNMBR
WHERE DOCDATE BETWEEN '20150216' AND '20150315' AND CUSTCLAS <>'VENDEDOR' AND BCHSOURC NOT LIKE '%Sales%'
AND RMDTYPAL=9 AND VOIDSTTS=0