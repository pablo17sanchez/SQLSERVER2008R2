use GPHN
go
select userid,bchsttus, * from sy00500
where bachnumb = 'sarah'
order by bachnumb

/*
update  sy00500
set bchsttus = '0'
where bachnumb = 'sarah'
*/
