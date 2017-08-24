select * from RelacionConduce
--where NoDocumento like '%782'

where IdVendedor = '4149'
order by NoDocumento

/*
INSERT INTO dbo.RelacionConduce
         (NoDocumento,TipoDocumento, IdVendedor, CodRuta, Fecha, Ayudante1, IdUsuario, FechaCreacion)
VALUES   ('000000000000782','Conduce','4149','SD300-13','2012-05-12','2685','raquel.sierra','2012-05-12')



*/


/*
update relacionconduce
set numeroconduce = '000000000000782'
where nodocumento = 'RC01624371'
*/