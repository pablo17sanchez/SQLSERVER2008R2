select   PALMID,CODCLIE,COUNT(*) as CANTIDAD, 'DELETE TOP (1)   from alaska_pcomdb..CODCLIE WHERE PALMID='''+PALMID+''' AND CODCLIE='''+CODCLIE+''''
 from alaska_pcomdb..OUT_CLIENTES group by PALMID,CODCLIE HAVING COUNT(*)>