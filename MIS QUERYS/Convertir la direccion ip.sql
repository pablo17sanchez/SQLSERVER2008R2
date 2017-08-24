

--select * from dbo.WebProxyLog
SELECT CAST(ClientIP / 256 / 256 / 256 % 256 AS VARCHAR) + '.' + CAST(ClientIP / 256 / 256 % 256 AS VARCHAR) + '.' 
+ CAST(ClientIP / 256 % 256 AS VARCHAR) + '.' + CAST(ClientIP % 256 AS VARCHAR) AS IP FROM WebProxyLog 
