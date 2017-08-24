/* Script to create bcp commands to export data for all tables. */ 
SET QUOTED_IDENTIFIER OFF
select 'bcp "TWO..' + name + '" out ' + name + '.out -e ' + name + '.err -c -b 1000 -U sa -P password -t "|" -S SERVERNAME -r "#EOR#\n"'
from sysobjects where type = 'U' order by name
--
/* Script to create bcp commands to import data for all tables. */ 
SET QUOTED_IDENTIFIER OFF	
select 'bcp "TWO..' + name + '" in ' + name + '.out -e ' + name + '.err	 -c -b 1000 -U sa -P password -t "|" -S SERVERNAME -r "#EOR#\n"'
from sysobjects where type = 'U' order by name
--
/* Script to remove all data from all user tables in the company database */
SET QUOTED_IDENTIFIER OFF
if exists (select * from sysobjects where name = 'RM_NationalAccounts_MSTR_FKC')
ALTER TABLE dbo.RM00105 
DROP CONSTRAINT RM_NationalAccounts_MSTR_FKC 
Go
declare @tablename char(255)
DECLARE t_cursor CURSOR for 
	select "truncate table " + name
	from sysobjects where type = 'U'
	set NOCOUNT on
	open t_cursor
	FETCH NEXT FROM t_cursor INTO @tablename
	while (@@fetch_status <> -1)
	begin
	if (@@fetch_status <> -2)
	begin
	exec (@tablename)
	end	 
	FETCH NEXT FROM t_cursor into @tablename
	end
DEALLOCATE t_cursor
GO
ALTER TABLE dbo.RM00105 ADD 
	CONSTRAINT RM_NationalAccounts_MSTR_FKC FOREIGN KEY 
	(
	CPRCSTNM
	) REFERENCES dbo.RM00101 (
	CUSTNMBR 
	)
GO 
