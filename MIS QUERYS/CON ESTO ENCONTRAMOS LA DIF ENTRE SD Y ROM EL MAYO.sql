/*
select * from sop30200
where TRXDATE between '2011.05.01' and '2011.05.31'
where JRNENTRY in ('1525686', '1525687', '1525685', '1497692', '1497677', '1497678')


select * from GL20000
where aaGLWorkHdrID = 32768
*/
select * from sop30200
order by ACTINDX
where DOCDATE between '2011.05.01' and '2011.05.31' and VOIDSTTS <> 1 ---and DOCAMNT > 0
order by DOCAMNT desc

--CON ESTA CONSULTA ENCONTRAMOS EL DESCUADRE DE DE SANTO DOMIGO Y ROMANA---
select SUM(crdtamnt) from SOP30200 a1 inner join SOP10102 a2 
on a1.SOPNUMBE = a2.SOPNUMBE 
--where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('696', '694', '714','711' ) and a1.LOCNCODE <> 'sanisidro' and a1.VOIDSTTS <> 1
--where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('700', '701', '713', '716') and a1.LOCNCODE = 'romana' and a1.VOIDSTTS <> 1
where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('697', '698', '712', '715') and a1.LOCNCODE = 'BAVARO' and a1.VOIDSTTS <> 1
order by a1.LOCNCODE


select * from SOP30200 a1 inner join SOP10102 a2 
on a1.SOPNUMBE = a2.SOPNUMBE 
--where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('696', '694', '714','711' ) and a1.LOCNCODE <> 'sanisidro'
--where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('700', '701', '713', '716') and a1.LOCNCODE = 'romana' and a1.VOIDSTTS <> 1
where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('697', '698', '712', '715') and a1.LOCNCODE <> 'BAVARO' and a1.VOIDSTTS <> 1
order by LOCNCODE

select * from SOP00200
where ReqShipDate between '2011.05.01' and '2011.05.31' and LOCNCODE like 'ro%' --and VOIDSTTS = 0 and SOPTYPE = 3 --and a2.ACTINDX in ('700', '701', '713', '716') and a1.LOCNCODE = 'romana' and a1.VOIDSTTS <> 1 and
