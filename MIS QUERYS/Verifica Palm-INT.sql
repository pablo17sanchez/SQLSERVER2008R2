use palmcomsync

--insert into in_factura
select * from in_factura
where palmid = 'ita022' and fechafac = '2009.12.27'

delete from in_detafac
where facnum between 'F14714    ' and 'F14737'

select * from sitgpintegration..transaccionventa
where nodocumento between 'F3614714      ' and 'F3614737'
order by idventa

delete from sitgpintegration..transaccionventa
where idventa between '72536    ' and '72559'
