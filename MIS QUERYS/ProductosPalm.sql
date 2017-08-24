
select * from import..art_alm


insert into palmcomsync..out_producto
(categoria,codprod,costo,descrip,existencia,gravable,palmid,precmax,precmin)
select cast(a.itmclscd as nvarchar(10))Categoria,cast(a.itemnmbr as nvarchar(16))CodProd,cast(a.currcost as real) Costo,cast(a.itemdesc as nvarchar(35))Descrip,cast('99999' as Real)Existencia,'Gravable'= cast(CASE WHEN a.itmclscd = 'OP' THEN 'TRUE' ELSE '0'END as nvarchar(10)) ,cast(b.locncode as nvarchar(10))PalmId,cast (c.uomprice as real) PrecMax,'0' PrecMin from iv00101 a left join import..art_alm b on a.itemnmbr = b.itemnmbr left join iv00108 c on b.itemnmbr = c.itemnmbr
WHERE a.itmclscd in('OP') and c.prclevel = 'colmado' 

select * from palmcomsync..out_producto
where categoria = 'op'

select * from iv00108

select * from palmcomsync..o

select * from palmcomsync..out_config