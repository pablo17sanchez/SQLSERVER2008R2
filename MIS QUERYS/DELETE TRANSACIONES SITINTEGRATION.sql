SELECT * FROM dbo.TransaccionVentaItem
SELECT * FROM dbo.TransaccionVenta

WHERE Fecha < '2016.09.01'


/*
DELETE FROM dbo.TransaccionVentaItem
WHERE NOT EXISTS (SELECT * FROM dbo.TransaccionVenta 
WHERE dbo.TransaccionVentaItem.IDVenta = dbo.TransaccionVenta.IDVenta)

*/