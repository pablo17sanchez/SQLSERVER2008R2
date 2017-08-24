select * from in_factura
where fechafac between '2010.11.01' and '2010.11.10'

select  palmid,fechafac, COUNT(*)cantidad from IN_FACTURA_TEMP
where fechafac between '2010.11.01' and '2010.11.23'
group by PALMID, FECHAFAC
order by cantidad, PALMID

select * from OUT_CONFIG
where PALMID = 'hnt05    '