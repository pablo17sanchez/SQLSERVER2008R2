DECLARE @value varchar(50)
DECLARE @columndatatype varchar(50)
DECLARE @tabletype varchar(2)

SET @value = '00000000000023152'
SET @columndatatype = 'CHAR'
set @tabletype = 'u'


declare @tablename varchar(50)
declare @columnname varchar(50)
declare @columntype varchar(50)
declare @columnvalue varchar(50)
declare @sql varchar(1000)
declare @i int




create table #tt(TableName varchar(50),ColumnName varchar(50),Active int)

set nocount on
DECLARE Validate_Cursor CURSOR FOR


SELECT o.name, c.name,t.name

from sysobjects o inner join  syscolumns c on o.id=c.id
inner join systypes t on t.xtype=c.xtype
--and o.name='t_authorization'
 where o.type=@tabletype
 and t.name=@columndatatype
order by o.name desc
OPEN Validate_Cursor

FETCH NEXT FROM Validate_Cursor into @tablename,@columnname,@columntype




WHILE @@FETCH_STATUS = 0

BEGIN
---------------------------------------------




set nocount on

set @sql=N'insert #tt select '+ char(39) + @tablename + char(39) +N' as
TableName,'+
char(39) + @columnname+ char(39) +N' as ColumnName, count(' + @columnname +
N') as Active from ' + quotename(@tablename) +
N' where ' + @columnname + N'=' + char(39)+@value+char(39) +N' GROUP BY '
+@columnname
--select @sql
exec (@sql)

if @@error<>0
begin
print @sql
end

FETCH NEXT FROM Validate_Cursor into @tablename,@columnname,@columntype


--------------------------------------------
END

CLOSE Validate_Cursor

DEALLOCATE Validate_Cursor
print('========================================================================================================')
select *, ('SELECT * FROM ' + TableName + ' WHERE ' + ColumnName + ' = ' + '''' + @value + '''')  from #tt

drop table #tt