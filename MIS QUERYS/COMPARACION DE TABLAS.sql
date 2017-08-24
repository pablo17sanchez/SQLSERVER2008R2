select * from dbo.Table_mayo 
where NOT exists (select SOPNUMBE from  dbo.VENTAS_MAYO 
WHERE SOPNUMBE = SOPNUMBE)


