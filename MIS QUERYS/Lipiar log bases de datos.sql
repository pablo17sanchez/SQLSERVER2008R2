USE PalmComSync;

GO

-- cambiamos el recovery a nodo simple

ALTER DATABASE PalmComSync

SET RECOVERY SIMPLE;

GO

-- reducirmos el archivo log a 1 MB.

DBCC SHRINKFILE ('PalmComSync_Log', 1);

GO

-- devolvemos el nivel de recovery a full

ALTER DATABASE PalmComSync

SET RECOVERY FULL;

GO

----REVIZAR LOS ARCHIVOS DE LA BASE DE DE DATOS 

USE PalmComSync

SELECT * FROM sys.database_files