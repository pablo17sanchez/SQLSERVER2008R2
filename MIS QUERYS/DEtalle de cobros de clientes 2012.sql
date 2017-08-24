SELECT   r0.CPRCSTNM,
		 r0.CUSTNMBR,
		 REPLACE(r0.CUSTNAME,',',' ')CUSTNAME,
		 rmesp.Tipo_documento,
		 rmesp.DOCDATE,
		 rmesp.DOCNUMBR,
		 rmesp.SUBTOTAL,
		 rmesp.ITBIS,
		 rmesp.Monto,
		 saldoini.SALDO_INICIAL,
		 salf.PSALDO_FINAL,
		 APTODCNM'Documento_Aplica',
		 APFRMAPLYAMT'Monto_Aplicado',
		 rm1.APTODCDT'FECHA_DOCUMENTO',
		 ISNULL(s.DOCAMNT,0) 'Monto Original Doc. Aplicado.' 
				 
FROM RM00101 r0 LEFT JOIN 
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
					rm.SLSAMNT'SUBTOTAL',
					rm.TAXAMNT'ITBIS',
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
		FROM RM20101 rm INNER JOIN RM00101 r1 ON r1.CUSTNMBR=rm.CUSTNMBR
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
					rm.SLSAMNT'SUBTOTAL',
					rm.TAXAMNT'ITBIS',
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
		FROM RM20101 rm INNER JOIN RM00101 r1 ON r1.CUSTNMBR=rm.CUSTNMBR
		WHERE rm.CPRCSTNM<>'' AND DOCDATE BETWEEN '20120101' AND '20121231'  AND VOIDSTTS=0
		AND RTRIM(CONVERT(varchar(50),BCHSOURC))+''+RTRIM(CONVERT(varchar(3),RMDTYPAL)) <> 'Sales Entry9' AND CASHAMNT=0
		AND r1.CUSTCLAS<>'VENDEDOR'
)rmesp ON r0.CUSTNMBR=rmesp.CUSTNMBR
LEFT JOIN (
			SELECT 
	                CUSTNMBR , 
					(((ISNULL(SUM(CASE WHEN Tipo_documento IN('Ventas') THEN Monto END),0)+ISNULL(SUM(CASE WHEN Tipo_documento IN('Nota Debito') THEN Monto END),0))-ISNULL(SUM(CASE WHEN Tipo_documento IN('Nota de Credito') THEN Monto END),0)-ISNULL(SUM(CASE WHEN Tipo_documento IN('Pagos') THEN  Monto END),0)-ISNULL(SUM(CASE WHEN Tipo_documento IN('Devolucion') THEN  Monto END),0)))'SALDO_INICIAL'
				 
				
				FROM (	SELECT 
						rm.CPRCSTNM,
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

) saldoini ON r0.CUSTNMBR=saldoini.CUSTNMBR
LEFT JOIN 
(	SELECT     
	                CUSTNMBR , 
				(((ISNULL(SUM(CASE WHEN Tipo_documento IN('Ventas') THEN Monto END),0)+ISNULL(SUM(CASE WHEN Tipo_documento IN('Nota Debito') THEN Monto END),0))-ISNULL(SUM(CASE WHEN Tipo_documento IN('Nota de Credito') THEN Monto END),0)-ISNULL(SUM(CASE WHEN Tipo_documento IN('Pagos') THEN  Monto END),0)-ISNULL(SUM(CASE WHEN Tipo_documento IN('Devolucion') THEN  Monto END),0)))'PSALDO_FINAL'
				 
				
				FROM (	SELECT 
				rm.CPRCSTNM,
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
		WHERE r1.CPRCSTNM='' AND DOCDATE <='20121231' AND VOIDSTTS=0
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

ON r0.CUSTNMBR=salf.CUSTNMBR
LEFT JOIN RM20201 rm1 ON rmesp.DOCNUMBR=rm1.APFRDCNM
LEFT JOIN SOP30200 s ON rm1.APTODCNM=s.SOPNUMBE

WHERE  r0.CUSTCLAS<>'VENDEDOR' --AND R0.CREATDDT<='20121231'
GROUP BY  r0.CPRCSTNM,
		 r0.CUSTNMBR,
		r0.CUSTNAME,
		 rmesp.Tipo_documento,
		 rmesp.DOCNUMBR,
		 rmesp.DOCDATE,
		 rmesp.SUBTOTAL,
		 rmesp.ITBIS,
		 rmesp.Monto,
		 saldoini.SALDO_INICIAL,
		 salf.PSALDO_FINAL,
		  APTODCNM,
		 APFRMAPLYAMT,
		  rm1.APTODCDT,
		  s.DOCAMNT
ORDER BY rmesp.DOCNUMBR