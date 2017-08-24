
------ VENTA PLANTA----------
SELECT itemnmbr, SUM (QUANTITY ) FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'    and LOCNCODE = 'sanisidro' and BACHNUMB   not like 'p%' AND BACHNUMB  not like '%-%' ---AND BACHNUMB like 'D%'
  group by ITEMNMBR
  order by ITEMNMBR
------- VENTA PUESTOS---------
  
SELECT ITEMNMBR  ,SUM (QUANTITY ) FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'   and LOCNCODE = 'sanisidro' and BACHNUMB    like 'p%' --and BACHNUMB  not like '%-%' --and BACHNUMB like 'D%'
  group by ITEMNMBR
  order by ITEMNMBR
  
  ------- VENTA RANCHERA---------
  
SELECT ITEMNMBR ,SUM (QUANTITY ) FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'   and LOCNCODE = 'sanisidro' and BACHNUMB   NOT like 'p%' and BACHNUMB   like '%-%' and BACHNUMB NOT like 'D%'
  group by ITEMNMBR
  order by ITEMNMBR
  
  /*
 SELECT DOCID, sum (QUANTITY)   FROM View_VentasGP2
WHERE  DOCDATE  between '2010.01.01' and  '2010.10.31' and  ITEMNMBR = 'pt100' and BACHNUMB like 'po%' and LOCNCODE = 'sanisidro'
  group by DOCID
  */
  
  
  ---venta distribuidor para sumar a planta---
  
  SELECT * FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'  and LOCNCODE = 'sanisidro' and idvendedor = 'D001' ---and BACHNUMB like 'san%'
  order by itemnmbr
  
  
  
  ----ventas ranchera por zona----
  
    ------- VENTA RANCHERA---------
  
SELECT idzona, SUM (QUANTITY ) FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'   and LOCNCODE = 'sanisidro' and BACHNUMB   NOT like 'p%' and BACHNUMB   like '%-%' and BACHNUMB NOT like 'D%'
  group by idzona
  order by idzona
  
  -----consulta detelle de venta por linea de negocio--------
  
  ------ VENTA PLANTA----------
SELECT * FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'    and LOCNCODE = 'sanisidro' and BACHNUMB   not like 'p%' AND BACHNUMB  not like '%-%'---AND BACHNUMB like 'D%'
  ---group by ITEMNMBR
  order by USER2ENT
------- VENTA PUESTOS---------
  
SELECT * FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'   and LOCNCODE = 'sanisidro' and BACHNUMB    like 'p%' --and BACHNUMB  not like '%-%' --and BACHNUMB like 'D%'
  ---group by ITEMNMBR
  order by ITEMNMBR
  
  ------- VENTA RANCHERA---------
  
SELECT * FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'   and LOCNCODE = 'sanisidro' and BACHNUMB   NOT like 'p%' and BACHNUMB   like '%-%' and BACHNUMB NOT like 'D%'
  ---group by ITEMNMBR
  order by ITEMNMBR 
  
  
  
  
  
  
  
  
  
  
  
  
  
  SELECT  CUSTNMBR, IdVendedor, COUNT(sopnumbe) FROM View_VentasGP2
WHERE DOCDATE  between '2010.01.01' and  '2010.10.31'    and LOCNCODE = 'sanisidro' and BACHNUMB   not like 'p%' AND BACHNUMB  not like '%-%' and IdVendedor > '0004'---AND BACHNUMB like 'D%'
  group by CUSTNMBR, IdVendedor
  order by CUSTNMBR