SELECT * FROM SOP10102
WHERE SOPNUMBE IN ( '10081060100310948    ', '10081060100154966    ', '10081060100310947    ')

--***  TIENEN ALMACEN SANISIDRO Y CUENTA BAVARO ***
select * from SOP30200 a1 inner join SOP10102 a2 
on a1.SOPNUMBE = a2.SOPNUMBE 
--where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('696', '694', '714','711' ) and a1.LOCNCODE <> 'sanisidro'
--where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('700', '701', '713', '716') and a1.LOCNCODE = 'romana' and a1.VOIDSTTS <> 1
where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('697', '698', '712', '715') and a1.LOCNCODE <> 'BAVARO' and a1.VOIDSTTS <> 1
order by LOCNCODE

--*** TIENEN ALMACEN BAVARO Y CUENTA SANSISDRO***
select * from SOP30200 a1 inner join SOP10102 a2 
on a1.SOPNUMBE = a2.SOPNUMBE 
where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('696', '694', '714','711' ) and a1.LOCNCODE <> 'sanisidro' and a1.VOIDSTTS <> 1
--where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('700', '701', '713', '716') and a1.LOCNCODE <> 'romana' and a1.VOIDSTTS <> 1
--where a1.DOCDATE between '2011.09.01' and '2011.09.30' and a2.ACTINDX in ('697', '698', '712', '715') and a1.LOCNCODE <> 'BAVARO' and a1.VOIDSTTS <> 1
order by LOCNCODE

