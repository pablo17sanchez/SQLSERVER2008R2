select * from RelacionConduce
--WHERE  IdVendedor = '3406'
where NoDocumento like '%3169493%'
WHERE fecha = '2012.11.02' and TipoDocumento = 'conduce' --and IdVendedor = '3724'
order by CodRuta 

/*
update RelacionConduce
set TipoDocumento = 'Conduce'
where NoDocumento = '000000000018042'
*/


INSERT INTO SITGPIntegration..RelacionConduce
         (NoDocumento,TipoDocumento, IdVendedor,CodRuta,Fecha,Ayudante1,Ayudante2,IdUsuario,FechaCreacion,NumeroConduce)values
         ('RC03169493','Recibo','5340','BA300-01','2017.03.09','5141', '','yenifer.ramirez',GETDATE(),'000000000193574')
         
     
select * from SITGPIntegration..RelacionConduce where NoDocumento='RC03169493'