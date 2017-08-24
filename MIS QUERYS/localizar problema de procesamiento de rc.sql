SELECT CUSTNMBR,CUSTNAME,R1.PRCLEVEL,UOMPRICE FROM IV00108 iv INNER JOIN RM00101 R1 ON iv.PRCLEVEL=R1.PRCLEVEL 
WHERE ITEMNMBR='PT300' AND INACTIVE=0 AND HOLD=0



SELECT * FROM RM10301 WHERE RMDTYPAL > 1 AND BACHNUMB = '1527-20140517' 
UNION ALL 
SELECT * FROM RM20101 WHERE RMDTYPAL > 1 AND BACHNUMB = '1527-20140517' 
UNION ALL 
SELECT * FROM RM10201 WHERE RMDTYPAL = 9 AND BACHNUMB = '1527-20140517'


 SELECT RTRIM(ID) CUSTNMBR, RTRIM(RECIBO) DOCNUMBR, 1 VOIDSTTS, RMDTYPAL, FECHA VOIDDATE, FECHA GLPOSTDT FROM 
 (SELECT BACHNUMB LOTE, DOCNUMBR RECIBO, CUSTNMBR ID, ORTRXAMT MONTO, TRXDSCRN CANTIDAD, 'NO' ANULADO, DOCDATE FECHA, RMDTYPAL FROM RM10201 
 UNION ALL SELECT BACHNUMB LOTE, DOCNUMBR RECIBO, CUSTNMBR ID, ORTRXAMT MONTO, TRXDSCRN CANTIDAD, CASE VOIDSTTS WHEN 0 THEN 'NO' WHEN 1 THEN 'SI' END ANULADO, DOCDATE FECHA, RMDTYPAL FROM RM20101) A WHERE EXISTS (SELECT 1 FROM RM00301 B WHERE A.ID = SLPRSNID) AND RMDTYPAL = 9 AND LOTE LIKE '1527-20140512%' AND ANULADO = 'NO' AND ID LIKE '1527%'
 
 
 SELECT COUNT (*) Cantidad FROM ( 
                      SELECT RMDTYPAL, 0 VOIDSTTS 
                      FROM RM10301 WHERE RMDTYPAL > 1 AND BACHNUMB = '1527-20140512'
                      UNION ALL 
                      SELECT RMDTYPAL, VOIDSTTS FROM RM20101 WHERE RMDTYPAL > 1 AND BACHNUMB = '1527-20140512' 
                      UNION ALL SELECT RMDTYPAL, 0 VOIDSTTS FROM RM10201 WHERE RMDTYPAL = 9 AND BACHNUMB = '1527-20140512' ) A 
                      WHERE VOIDSTTS = 0 AND RMDTYPAL = 9 
                      
                      
                      
                      
SELECT * FROM (                    
                      
SELECT BACHNUMB LOTE, 
       DOCNUMBR RECIBO, 
       CUSTNMBR ID, 
       ORTRXAMT MONTO, 
       TRXDSCRN CANTIDAD, 
       'NO' ANULADO, 
       DOCDATE FECHA, 
       RMDTYPAL 
FROM RM10201 
       UNION ALL 
SELECT BACHNUMB LOTE, 
       DOCNUMBR RECIBO, 
       CUSTNMBR ID, 
       ORTRXAMT MONTO, 
       TRXDSCRN CANTIDAD, 
       CASE VOIDSTTS WHEN 0 THEN 'NO' 
                     WHEN 1 THEN 'SI' END ANULADO, 
       DOCDATE FECHA, 
       RMDTYPAL 
FROM RM20101 ) AS A 
WHERE A.LOTE='1527-20140517' AND RMDTYPAL=9


SELECT RTRIM(ID) CUSTNMBR, 
       RTRIM(RECIBO) DOCNUMBR, 
       1 VOIDSTTS, 
       RMDTYPAL, 
       FECHA VOIDDATE, 
       FECHA GLPOSTDT 
       FROM (
             SELECT BACHNUMB LOTE, 
                    DOCNUMBR RECIBO, 
                    CUSTNMBR ID, 
                    ORTRXAMT MONTO, 
                    TRXDSCRN CANTIDAD, 
                    'NO' ANULADO, 
                    DOCDATE FECHA, 
                    RMDTYPAL 
              FROM RM10201 
              UNION ALL 
              SELECT BACHNUMB LOTE, 
                     DOCNUMBR RECIBO,
                     CUSTNMBR ID, 
                     ORTRXAMT MONTO, 
                     TRXDSCRN CANTIDAD, 
                     CASE VOIDSTTS WHEN 0 THEN 'NO' 
                                   WHEN 1 THEN 'SI' END ANULADO, 
                     DOCDATE FECHA, 
                     RMDTYPAL 
               FROM RM20101) A 
               WHERE EXISTS ( SELECT 1 
                              FROM RM00301 B WHERE A.ID = SLPRSNID) 
                              AND RMDTYPAL = 9 AND LOTE LIKE '1527-20140517%' 
                              AND ANULADO = 'NO' AND ID LIKE '1527%'
                              
                              
     SELECT * FROM SITGPIntegration..RelacionConduce
     WHERE NoDocumento='000000000080036'