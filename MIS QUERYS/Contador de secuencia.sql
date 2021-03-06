
--Primer paso

--- Preparar los recibos para insertar en una tabla todo depende de la nomenclatura

SELECT DOCDATE,DOCNUMBR,LEFT(DOCNUMBR,3)'CABEZA',RIGHT(RTRIM(DOCNUMBR),7)'SEC' --INTO import..rc2013d 
FROM RM20101
WHERE DOCDATE BETWEEN '20130101' AND '20131231' AND LEN(DOcnumbr)=10 AND RMDTYPAL=9 AND DOCNUMBR LIKE '%RC%'
ORDER BY DOCNUMBR

--Segundo paso
--Buscar el numero maximo lo cual debo colocar en el Contado.

DECLARE @MIN$ INT, 
        @MAX$ INT

SELECT @MIN$=MIN(SEC) FROM import..rc2013d 

SELECT @MAX$= MAX(SEC) FROM import..rc2013d 

SELECT @MAX$-@MIN$


--3ro paso
--Contador de secuencia
DECLARE @contador INT, @maximo INT,@valorInset INT
CREATE TABLE #recibosec(SECUENCIA NVARCHAR(50))
CREATE TABLE #secuencia(valores INT)
 
SET @contador = 1;

SET @maximo =322614;

SET @valorInset=1859637
WHILE @contador <= @maximo
BEGIN
INSERT INTO #secuencia VALUES (@valorInset)
SET @contador = @contador+ 1;
SET @valorInset=@valorInset+1
END

---Inserta en una segunda tabla ya con el encabezado del los recibos.

INSERT INTO #recibosec(SECUENCIA)
SELECT  'RC0'+CONVERT(VARCHAR(50),valores)  FROM #secuencia

---Selecciona las secuencia que no existe en la tabla son considerado saltos
SELECT secuencia
FROM #recibosec s 
WHERE SECUENCIA  NOT IN (SELECT DOCNUMBR FROM RM20101 r)
ORDER BY SECUENCIA

--Eliminar tabla Temporales.
--DROP TABLE #secuencia
--DROP TABLE #recibosec

----Fin del proceso



---Sacar los recibos que no estan el parametros de los cuales se considera
SELECT DOCDATE,DOCNUMBR,LEN(RTRIM(DOCNUMBR)) FROM RM20101
WHERE DOCDATE BETWEEN '20130101' AND '20131231' AND LEN(DOcnumbr)=10 
AND RMDTYPAL=9 AND DOCNUMBR LIKE '%RC%'
ORDER BY DOCNUMBR


SELECT   ('RC01496963')




SELECT MAX(DOCNUMBR), DOCDATE FROM RM20101
WHERE DOCDATE BETWEEN '20130101' AND '20131231' --AND '20120103' 
AND LEN(DOcnumbr)=10 
AND RMDTYPAL=9 AND DOCNUMBR LIKE '%RC%'
GROUP BY DOCDATE
ORDER BY MAX(DOCNUMBR)
--RC01531400        
--RC01551884           20120211   


SELECT DOCNUMBR,DOCDATE FROM  RM20101
WHERE DOCDATE BETWEEN '20130101' AND '20131231' --AND '20120103' 
--AND LEN(DOcnumbr)=10 
AND RMDTYPAL=9 AND DOCNUMBR LIKE '%RC%'
ORDER BY DOCNUMBR


--300-----RC01818273           	2012-11-03 00:00:00.000      


