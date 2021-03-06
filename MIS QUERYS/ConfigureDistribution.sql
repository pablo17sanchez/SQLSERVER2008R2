/****** Scripting replication configuration. Script Date: 6/6/17 12:47:53 a. m. ******/
/****** Please Note: For security reasons, all password parameters were scripted with either NULL or an empty string. ******/

/****** Installing the server as a Distributor. Script Date: 6/6/17 12:47:53 a. m. ******/
use master
exec sp_adddistributor @distributor = N'GEA-SRVDATA\SQLSERVER2008', @password = N''
GO
exec sp_adddistributiondb @database = N'distribution', @data_folder = N'G:\SQLDATA', @log_folder = N'D:\SQLLOG', @log_file_size = 2, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @security_mode = 1
GO

use [distribution] 
if (not exists (select * from sysobjects where name = 'UIProperties' and type = 'U ')) 
	create table UIProperties(id int) 
if (exists (select * from ::fn_listextendedproperty('SnapshotFolder', 'user', 'dbo', 'table', 'UIProperties', null, null))) 
	EXEC sp_updateextendedproperty N'SnapshotFolder', N'\\Gea-srvdata\snapshotfolder', 'user', dbo, 'table', 'UIProperties' 
else 
	EXEC sp_addextendedproperty N'SnapshotFolder', N'\\Gea-srvdata\snapshotfolder', 'user', dbo, 'table', 'UIProperties'
GO

exec sp_adddistpublisher @publisher = N'GEA-SRVDATA\SQLSERVER2008', @distribution_db = N'distribution', @security_mode = 0, @login = N'sa', @password = N'', @working_directory = N'\\Gea-srvdata\snapshotfolder', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER'
GO
