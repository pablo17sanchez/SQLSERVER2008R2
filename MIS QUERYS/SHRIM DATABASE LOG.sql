USE PalmComSync;
GO
-- cambiamos el recovery a nodo simple
ALTER DATABASE PalmComSync
SET RECOVERY SIMPLE;
GO
-- reducirmos el archivo log a 1 MB.
DBCC SHRINKFILE ('PalmComSync_Log', 20);
GO
-- devolvemos el nivel de recovery a full
ALTER DATABASE PalmComSync
SET RECOVERY FULL;
GO

USE SITGPIntegration
SELECT * FROM sys.database_files