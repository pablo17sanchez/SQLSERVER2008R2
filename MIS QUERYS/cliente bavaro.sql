SELECT c.*,
       a.*
FROM  VW_ClientesGPnulo c 
                           LEFT JOIN (
SELECT CUSTNMBR, 
       ITEMNMBR'EQUIPO',
       SERLNMBR'SERIE',
       OFFID,
       INSTDTE'FECHA_INST',
       REFRENCE'REFERENCIA',
       USERDEF1'FICHA',
       USRDEF05'CAPACIDAD' FROM SVC00300 
						WHERE   Version<>'') a ON c.CodCliente=a.CUSTNMBR
WHERE c.CodCliente IN (SELECT CUSTNMBR FROM vw_VentasGP
						WHERE LOCNCODE='BAVARO')
						
						
						
SELECT CUSTNMBR, ITEMNMBR'EQUIPO',
       SERLNMBR'SERIE',
       OFFID,
       INSTDTE'FECHA_INST',
       REFRENCE'REFERENCIA',
       USERDEF1'FICHA',
       USRDEF05'CAPACIDAD' FROM SVC00300 
WHERE OFFID='BAV' AND Version<>''



 