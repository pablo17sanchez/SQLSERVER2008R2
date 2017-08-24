use palmcomsync

delete from out_clientes
where palmid = 'ita032'

insert into out_clientes
(balance,cedula,codclie,direccionc,limcred,nombre,palmid,exon,noncf,gob,consfin,nomesc,sector,telefono1,telefono2,ciudad)
select balance,replace((rtrim(cedula)),'-','')cedula,cod_cliente,direccion,limcred,nombre,palmid,exon,noncf,gob,consfin,nomesc,rtrim(sector)Sector,rtrim(tel1)tel1,rtrim(tel2)Tel2,ciudad from dbo.vw_Clientes_Palm

where palmid = 'hnt21'

select * from dbo.out_clientes


select * from dbo.vw_Clientes_Palm

select * from hndbasegp..rvend_cte


--group by nombreruta
--order by nombreruta
