select * from RelacionConduce
--WHERE  IdVendedor = '3406'
--where NoDocumento like '%3169493%'
WHERE fecha = '2012.11.02' and TipoDocumento = 'conduce' --and IdVendedor = '3724'
order by CodRuta 

/*
update RelacionConduce
set TipoDocumento = 'Recibo Ingreso'
where NoDocumento = 'RC03169493'

*/
/*
INSERT INTO SITGPIntegration..RelacionConduce
         (NoDocumento,TipoDocumento, IdVendedor,CodRuta,Fecha,Ayudante1,Ayudante2,IdUsuario,FechaCreacion,NumeroConduce)values
         ('RC03169493','Recibo Ingreso','5340','BA300-01','2017.03.09','5141', '','yenifer.ramirez',GETDATE(),'000000000193574')
        */ 
     
select TipoDocumento,COUNT(*) from SITGPIntegration..RelacionConduce group by TipoDocumento




select TipoDocumento,COUNT(*) from SITGPIntegration..RelacionConduce GROUP BY TipoDocumento



/*

exec spBuscarDebeEntregaryEntregado '000000000193574'
*/

--BUSCAR RECIBO
use SITGPIntegration
SELECT * FROM RelacionConduce
WHERE IDVendedor = '5340' AND TipoDocumento = 'Recibo Ingreso'
AND Fecha >= '2017-03-09' AND Fecha <='2017-03-09'
---BUSCAR CONDUCE
use SITGPIntegration
SELECT * FROM RelacionConduce
WHERE IDVendedor = '5340' AND TipoDocumento = 'Conduce'
AND Fecha >= '2017-03-09' AND Fecha <='2017-03-09'