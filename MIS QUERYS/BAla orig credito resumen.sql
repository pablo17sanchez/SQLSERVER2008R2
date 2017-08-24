SELECT   rmesp.CPRCSTNM,
		 rmesp.CUSTNMBR,
		 REPLACE(rmesp.CUSTNAME,',',' ')CUSTNAME,
		 rmesp.Tipo_documento,
		 --rmesp.DOCDATE,
		-- rmesp.DOCNUMBR,
		 SUM(rmesp.Monto)'Monto',
		 saldoini.SALDO_INICIAL,
		 salf.PSALDO_FINAL--,
		-- APTODCNM'Documento_Aplica',
		-- APFRMAPLYAMT'Monto_Aplicado',
		-- rm1.APTODCDT'FECHA_DOCUMENTO',
		-- rm1.APPTOAMT'Monto'
				 
FROM 
(SELECT rm.CPRCSTNM,
				rm.CUSTNMBR,
				r1.CUSTNAME,
				case RMDTYPAL
					when 1 then 'Ventas'
					when 3 then 'Nota Debito'
					when 4 then 'Cambio Financiero'
					when 5 then 'Service Repair'
					when 6 then 'Garantia'
					when 7 then 'Nota de Credito'
					when 8 then 'Devolucion'
					when 9 then 'Pagos'
				else 'Other'end
					Tipo_documento, 
					DOCNUMBR,
						case RMDTYPAL
							when 1 then ORTRXAMT
							when 3 then ORTRXAMT
							when 4 then ORTRXAMT
							when 5 then ORTRXAMT
							when 6 then ORTRXAMT
							when 7 then ORTRXAMT
							when 8 then ORTRXAMT
							when 9 then ORTRXAMT
						else 'Other'end 'Monto',
						DOCDATE
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM='' AND DOCDATE BETWEEN '20120101' AND '20121231' AND VOIDSTTS=0 
		AND RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9' AND CASHAMNT=0
		AND r1.CUSTCLAS<>'VENDEDOR'
		UNION ALL
			SELECT rm.CPRCSTNM,
				rm.CUSTNMBR,
				r1.CUSTNAME,
				
				case RMDTYPAL
					when 1 then 'Ventas'
					when 3 then 'Nota Debito'
					when 4 then 'Cambio Financiero'
					when 5 then 'Service Repair'
					when 6 then 'Garantia'
					when 7 then 'Nota de Credito'
					when 8 then 'Devolucion'
					when 9 then 'Pagos'
				else 'Other'end 
					Tipo_documento, 
					DOCNUMBR,
					case RMDTYPAL
							when 1 then ORTRXAMT
							when 3 then ORTRXAMT
							when 4 then ORTRXAMT
							when 5 then ORTRXAMT
							when 6 then ORTRXAMT
							when 7 then ORTRXAMT
							when 8 then ORTRXAMT
							when 9 then ORTRXAMT
						else 'Other'end 'Monto',
						DOCDATE
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM<>'' AND DOCDATE BETWEEN '20120101' AND '20121231'  AND VOIDSTTS=0
		AND RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9' AND CASHAMNT=0
		AND r1.CUSTCLAS<>'VENDEDOR'
)rmesp 
LEFT JOIN (
			SELECT 
	                CUSTNMBR , 
					(((ISNULL(SUM(CASE WHEN Tipo_documento IN('Ventas') THEN Monto END),0)+ISNULL(SUM(CASE WHEN Tipo_documento IN('Nota Debito') THEN Monto END),0))-ISNULL(SUM(CASE WHEN Tipo_documento IN('Nota de Credito') THEN Monto END),0)-ISNULL(SUM(CASE WHEN Tipo_documento IN('Pagos') THEN  Monto END),0)-ISNULL(SUM(CASE WHEN Tipo_documento IN('Devolucion') THEN  Monto END),0)))'SALDO_INICIAL'
				 
				
				FROM (	SELECT rm.CPRCSTNM,
				rm.CUSTNMBR,
				r1.CUSTNAME,
				
				case RMDTYPAL
					when 1 then 'Ventas'
					when 3 then 'Nota Debito'
					when 4 then 'Cambio Financiero'
					when 5 then 'Service Repair'
					when 6 then 'Garantia'
					when 7 then 'Nota de Credito'
					when 8 then 'Devolucion'
					when 9 then 'Pagos'
				else 'Other'end 
					Tipo_documento, 
					DOCNUMBR,
						case RMDTYPAL
							when 1 then ORTRXAMT
							when 3 then ORTRXAMT
							when 4 then ORTRXAMT
							when 5 then ORTRXAMT
							when 6 then ORTRXAMT
							when 7 then ORTRXAMT
							when 8 then ORTRXAMT
							when 9 then ORTRXAMT
						else 'Other'end 'Monto'
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM='' AND DOCDATE <='20111231' AND VOIDSTTS=0
		AND RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9' AND CASHAMNT=0
		AND r1.CUSTCLAS<>'VENDEDOR'
		UNION ALL
			SELECT rm.CPRCSTNM,
				rm.CUSTNMBR,
				r1.CUSTNAME,
				
				case RMDTYPAL
					when 1 then 'Ventas'
					when 3 then 'Nota Debito'
					when 4 then 'Cambio Financiero'
					when 5 then 'Service Repair'
					when 6 then 'Garantia'
					when 7 then 'Nota de Credito'
					when 8 then 'Devolucion'
					when 9 then 'Pagos'
				else 'Other'end 
					Tipo_documento, 
					DOCNUMBR,
					case RMDTYPAL
							when 1 then ORTRXAMT
							when 3 then ORTRXAMT
							when 4 then ORTRXAMT
							when 5 then ORTRXAMT
							when 6 then ORTRXAMT
							when 7 then ORTRXAMT
							when 8 then ORTRXAMT
							when 9 then ORTRXAMT
						else 'Other'end 'Monto'
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM<>'' AND DOCDATE <='20111231'  AND VOIDSTTS=0
		AND RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9' AND CASHAMNT=0
		AND r1.CUSTCLAS<>'VENDEDOR'
)rmesp 
--WHERE  rmesp.CUSTNMBR='11162'
GROUP BY rmesp.CUSTNMBR

) saldoini ON rmesp.CUSTNMBR=saldoini.CUSTNMBR
LEFT JOIN 
(	SELECT     
	                CUSTNMBR , 
				(((ISNULL(SUM(CASE WHEN Tipo_documento IN('Ventas') THEN Monto END),0)+ISNULL(SUM(CASE WHEN Tipo_documento IN('Nota Debito') THEN Monto END),0))-ISNULL(SUM(CASE WHEN Tipo_documento IN('Nota de Credito') THEN Monto END),0)-ISNULL(SUM(CASE WHEN Tipo_documento IN('Pagos') THEN  Monto END),0)-ISNULL(SUM(CASE WHEN Tipo_documento IN('Devolucion') THEN  Monto END),0)))'PSALDO_FINAL'
				 
				
				FROM (	SELECT rm.CPRCSTNM,
				rm.CUSTNMBR,
				r1.CUSTNAME,
				
				case RMDTYPAL
					when 1 then 'Ventas'
					when 3 then 'Nota Debito'
					when 4 then 'Cambio Financiero'
					when 5 then 'Service Repair'
					when 6 then 'Garantia'
					when 7 then 'Nota de Credito'
					when 8 then 'Devolucion'
					when 9 then 'Pagos'
				else 'Other'end 
					Tipo_documento, 
					DOCNUMBR,
						case RMDTYPAL
							when 1 then ORTRXAMT
							when 3 then ORTRXAMT
							when 4 then ORTRXAMT
							when 5 then ORTRXAMT
							when 6 then ORTRXAMT
							when 7 then ORTRXAMT
							when 8 then ORTRXAMT
							when 9 then ORTRXAMT
						else 'Other'end 'Monto'
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM='' AND DOCDATE <='20121231' AND VOIDSTTS=0
		AND RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9' AND CASHAMNT=0
		AND r1.CUSTCLAS<>'VENDEDOR'
		UNION ALL
			SELECT rm.CPRCSTNM,
				rm.CUSTNMBR,
				r1.CUSTNAME,
				
				case RMDTYPAL
					when 1 then 'Ventas'
					when 3 then 'Nota Debito'
					when 4 then 'Cambio Financiero'
					when 5 then 'Service Repair'
					when 6 then 'Garantia'
					when 7 then 'Nota de Credito'
					when 8 then 'Devolucion'
					when 9 then 'Pagos'
				else 'Other'end 
					Tipo_documento, 
					DOCNUMBR,
					case RMDTYPAL
							when 1 then ORTRXAMT
							when 3 then ORTRXAMT
							when 4 then ORTRXAMT
							when 5 then ORTRXAMT
							when 6 then ORTRXAMT
							when 7 then ORTRXAMT
							when 8 then ORTRXAMT
							when 9 then ORTRXAMT
						else 'Other'end 'Monto'
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM<>'' AND DOCDATE <= '20121231'  AND VOIDSTTS=0
		AND RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9' AND CASHAMNT=0
		AND r1.CUSTCLAS<>'VENDEDOR'
)rmesp 
--WHERE  rmesp.CUSTNMBR='11162'
GROUP BY rmesp.CUSTNMBR

			)salf 

ON rmesp.CUSTNMBR=salf.CUSTNMBR
--LEFT JOIN RM20201 rm1 ON rmesp.DOCNUMBR=rm1.APFRDCNM

WHERE  rmesp.CPRCSTNM=''
GROUP BY  rmesp.CPRCSTNM,
		 rmesp.CUSTNMBR,
		 rmesp.CUSTNAME,
		 rmesp.Tipo_documento,
		-- rmesp.DOCNUMBR,
		-- rmesp.DOCDATE,
		-- rmesp.Monto,
		 saldoini.SALDO_INICIAL,
		 salf.PSALDO_FINAL--,
		 -- APTODCNM,
		-- APFRMAPLYAMT,
		 -- rm1.APTODCDT,
		 --  rm1.APPTOAMT
ORDER BY rmesp.CUSTNMBR





SELECT *
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM='' AND DOCDATE BETWEEN '20120101' AND '20120131' AND VOIDSTTS=0 AND CASHAMNT=0 AND RMDTYPAL=9
		AND RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9'
		--GROUP BY RMDTYPAL
		
		
SELECT * FROM RM20201
WHERE APFRDCNM='RC01534011'        



SELECT  RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL))
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM='' AND DOCDATE BETWEEN '20120101' AND '20121231' AND VOIDSTTS=0 AND CASHAMNT=0 /*AND RMDTYPAL IN (9) 
		AND BCHSOURC IN ('RM_Cash','Sales Entry')*/ AND  
		
		RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9'


