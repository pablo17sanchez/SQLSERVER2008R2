select *
FROM PalmComSync..[VW_CLIENTES_GP] c 
  INNER JOIN  PalmComSync..GP_CLIENTEDIASRUTA i ON c.COD_CLIENTE=i.CodCliente 
  INNER JOIN  PalmComSync..GP_RUTA RV ON I.NombreRuta=rv.NombreRuta 
  INNER JOIN PalmComSync..OUT_CONFIG ou ON rv.IdVendedor=ou.IDVENDEDOR
  WHERE   i.NombreRuta='SD103-03'
 -- AND IDVENDEDOR=''
 -- and PALMID=''

  
  

  
  
  
  

  
