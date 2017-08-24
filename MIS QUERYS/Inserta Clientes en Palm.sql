--select * from coordenadas1

declare @idVend varchar(10)
set @idvend = 3136      

delete from rvend_cte
where cod_vend = @IdVend      

insert into hndbasegp..rvend_cte
(cod_vend,custnmbr,custname)
select idvendedor,codigo,(select custname from gphn..rm00101 where custnmbr = codigo)  Custname from coordenadas1
where idvendedor = @IdVend 
