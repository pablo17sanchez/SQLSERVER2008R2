SELECT * FROM IN_FACTURA_TEMP
WHERE IDVENDEDOR ='4438' AND FECHAFAC BETWEEN '20140307' AND '20140307'


SELECT * FROM OUT_CONFIG
WHERE IDVENDEDOR='4229'

SELECT * FROM GPHN..sop10100
WHERE SOPNUMBE='F0400046635'

SELECT * FROM SITGPIntegration..RelacionConduce
WHERE NoDocumento='000000000073811'

SELECT * FROM SITGPIntegration..RelacionConduce
WHERE NoDocumento LIKE '%SANI-000258327%' AND IdUsuario=''

SELECT * FROM SITGPIntegration..RelacionConduce
WHERE IdVendedor='4438' AND Fecha='2014-03-07'

--vieja arriba, nueva abajo
/*
UPDATE P
SET P.PRECIO1=A.PRECIO1,P.PRECIO2=A.PRECIO2,P.PRECIO3=A.PRECIO3,P.PRECMAX=A.PRECMAX
FROM OUT_PRODUCTO P INNER JOIN (SELECT * FROM OUT_PRODUCTO WHERE PALMID='GEA089') A ON P.CODPROD=A.CODPROD
WHERE P.PALMID='GEA079' */


SELECT *  FROM OUT_PRODUCTO P INNER JOIN PalmComSyncRS..OUT_PRODUCTO A ON P.CODPROD=A.CODPROD AND P.PALMID=A.PALMID
WHERE P.PALMID='GEA088'