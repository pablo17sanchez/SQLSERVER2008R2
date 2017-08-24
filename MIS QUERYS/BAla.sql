	SELECT    rmesp.CPRCSTNM,  
	                CUSTNMBR , 
				((SUM(CASE WHEN Tipo_documento IN('Ventas') THEN Monto END)-SUM(CASE WHEN Tipo_documento IN('Nota de Credito') THEN Monto END))-SUM(CASE WHEN Tipo_documento IN('Pagos') THEN  Monto END))'PSALDO_FINAL'
				 
				
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
							when 1 then SLSAMNT
							when 3 then ORTRXAMT
							when 4 then SLSAMNT
							when 5 then SLSAMNT
							when 6 then SLSAMNT
							when 7 then ORTRXAMT
							when 8 then ORTRXAMT
							when 9 then ORTRXAMT
						else 'Other'end 'Monto'
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM='' AND DOCDATE BETWEEN '20120101'AND '20121231' AND VOIDSTTS=0
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
							when 1 then SLSAMNT
							when 3 then ORTRXAMT
							when 4 then SLSAMNT
							when 5 then SLSAMNT
							when 6 then SLSAMNT
							when 7 then ORTRXAMT
							when 8 then ORTRXAMT
							when 9 then ORTRXAMT
						else 'Other'end 'Monto'
		FROM RM20101 rm INNER JOIN RM00101 r1 ON rm.CUSTNMBR=r1.CUSTNMBR
		WHERE rm.CPRCSTNM<>'' AND DOCDATE BETWEEN '20120101'AND '20121231'  AND VOIDSTTS=0
)rmesp 
--WHERE  rmesp.CUSTNMBR='11162'
GROUP BY rmesp.CUSTNMBR,rmesp.CPRCSTNM
ORDER BY rmesp.CPRCSTNM
		
		
/*		
SELECT CUSTNMBR, SUM(SMRYSALS)'VEN',SUM(SMRYCRCD)'CREDITO' FROM RM00104
WHERE YEAR1='2012' AND CUSTNMBR='11162' AND HISTTYPE=0
GROUP BY CUSTNMBR

SELECT * FROM RM00104
WHERE YEAR1='2012' AND CUSTNMBR='11162' AND HISTTYPE=0
GROUP BY CUSTNMBR

		
SELECT * FROM RM00104
WHERE YEAR1='2012' AND CUSTNMBR='11162' AND HISTTYPE=0
GROUP BY CUSTNMBR

SELECT * FROM RM20101
WHERE DOCDATE BETWEEN '20120101' AND '20121231'  AND CPRCSTNM='11162'
*/

SELECT * FROM RM20101
WHERE DOCDATE <= '20111231'  AND CUSTNMBR='11218'




SELECT * FROM vw_VentasGP
WHERE CUSTNMBR='11162' AND DOCDATE BETWEEN '20120101'AND '20121231' 