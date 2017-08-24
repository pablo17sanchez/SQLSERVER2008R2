select * from RM00101 

select custclas, COUNT(CUSTNMBR) Cantidad_Clientes from RM00101 
group by CUSTCLAS
order by Cantidad_Clientes