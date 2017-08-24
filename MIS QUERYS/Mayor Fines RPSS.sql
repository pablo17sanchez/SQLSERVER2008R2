SELECT A.SOURCDOC'Doc. Origen',
	   A.JRNENTRY'Entrada de Diario',
       A.AÑO,
       A.Series,
       A.CUENTA,
       A.TRXDATE'Fecha',
	   REPLACE(A.DESCRIPCION,',',' ')'Descripcion de la Cuenta',
	   A.REFRENCE'Referencia Documento Origen',
	   A.DSCRIPTN'Descripcion de Transaccion',
       A.ORCTRNUM'Numero Documento',
       A.ORMSTRID'Id Cliente o Proveedor',
       REPLACE(A.ORMSTRNM,',',' ')'Nombre',
       A.ORDOCNUM'Numero Documento Origen',
       A.Tipo_transaccion,
       SUM(A.DEBITO)'DEBITO',
       SUM(A.CREDITO)'CREDITO',
       ISNULL(A.SALDO_INICIAL,0)'SALDO_INICIAL',
       A.ANULADO
FROM (
		SELECT G3.SOURCDOC,
		       JRNENTRY,
		       G3.HSTYEAR'AÑO',
		       G3.TRXDATE,
		       G3.ORCTRNUM,
		       G3.ORMSTRID,
		       G3.ORMSTRNM,
		       G3.ORDOCNUM,
		       (RTRIM(ACTNUMBR_1)+'-'+RTRIM(ACTNUMBR_2)+'-'+RTRIM(ACTNUMBR_3))'CUENTA',
		       ACTDESCR AS 'DESCRIPCION',
		       G3.DSCRIPTN,
		       G3.REFRENCE,
		       CASE VOIDED WHEN 0 THEN 'NO' ELSE 'SI' END'ANULADO',
		       CASE SERIES WHEN 1 THEN 'TODOS'
		                   WHEN 2 THEN 'FINANCIERO'
		                   WHEN 3 THEN 'VENTAS'
		                   WHEN 4 THEN 'COMPRAS'
		                   WHEN 5 THEN 'INVENTARIO'
		                   WHEN 6 THEN 'Nomina'
		                   WHEN 7 THEN 'Proyecto'
		                   WHEN 10 THEN 'Terceros'
		                   ELSE 'Otros' END 'Series',
		       CRDTAMNT'CREDITO',
		       DEBITAMT'DEBITO',
		       P.PERDBLNC'SALDO_INICIAL',
		       CASE WHEN SERIES=2 AND ORTRXTYP=0 THEN 'Entrada de Diario Financiero'
		            WHEN SERIES=2 AND ORTRXTYP=2 THEN 'Recibo de Transaccion Bancarias'
		            WHEN SERIES=2 AND ORTRXTYP=5 THEN 'Aumento de Ajuste T. Bancarias'
		            WHEN SERIES=2 AND ORTRXTYP=6 THEN 'Disminucion de Ajuste T. Bancarias'
		            WHEN SERIES=3 AND ORTRXTYP=1 THEN 'Factura'
		            WHEN SERIES=3 AND ORTRXTYP=3 THEN 'Factura'
		            WHEN SERIES=3 AND ORTRXTYP=4 THEN 'Factura'
		            WHEN SERIES=3 AND ORTRXTYP=7 THEN 'Nota de Credito'
		            WHEN SERIES=3 AND ORTRXTYP=8 THEN 'Aplicacion a Documento por pagar'
		            WHEN SERIES=3 AND ORTRXTYP=9 THEN 'Pagos'
		            WHEN SERIES=4 AND ORTRXTYP=0 THEN 'Compras otros'
		            WHEN SERIES=4 AND ORTRXTYP=1 THEN 'Factura de Compras'
		            WHEN SERIES=4 AND ORTRXTYP=2 THEN 'Factura de Compras'
		            WHEN SERIES=4 AND ORTRXTYP=3 THEN 'Nota de Debito de Compras'
		            WHEN SERIES=4 AND ORTRXTYP=4 THEN 'Devolucion'
		            WHEN SERIES=4 AND ORTRXTYP=5 THEN 'Devolucion credito'
		            WHEN SERIES=4 AND ORTRXTYP=6 THEN 'Cheques' 
		            WHEN SERIES=5 AND ORTRXTYP=0 THEN 'Entrada de inventario generada por el sistema' 
		            WHEN SERIES=5 AND ORTRXTYP=1 THEN 'Entrada o salida mercancia' 
		            WHEN SERIES=5 AND ORTRXTYP=2 THEN 'Variacion inventario' 
		            WHEN SERIES=5 AND ORTRXTYP=3 THEN 'Transferencia inventario' 
		            ELSE 'Otras Transaccion' END'Tipo_transaccion'
		FROM GL30000 G3 INNER JOIN GL00100 G1 ON G3.ACTINDX=G1.ACTINDX LEFT JOIN (SELECT ACTINDX,PERDBLNC FROM GL10111
WHERE YEAR1='2012' AND PERIODID=0) P ON G3.ACTINDX=P.ACTINDX
WHERE G3.HSTYEAR='2012' 

)AS A
WHERE TRXDATE BETWEEN '20121201' AND '20121231' 
GROUP BY A.SOURCDOC,
	   A.JRNENTRY,
       A.AÑO,
       A.Series,
       A.CUENTA,
       A.TRXDATE,
	   A.DESCRIPCION,
	   A.REFRENCE,
	   A.DSCRIPTN,
       A.ORCTRNUM,
       A.ORMSTRID,
       A.ORMSTRNM,
       A.Tipo_transaccion,
       A.ORDOCNUM,
       A.SALDO_INICIAL,
       A.ANULADO
ORDER BY A.JRNENTRY