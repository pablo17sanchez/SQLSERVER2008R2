
/*
IV00101 – Item Master
IV00102 – Item Quantity Master
IV00103 – Item Vendor Master
IV00104 – Item Kit Master
IV00107 – Item Price List Options
IV00108 – Item Price List
IV00118 – Item Cost Change History
IV00200 – Item Serial Number Master
IV00300 – Lot Number Master
IV00301 – Lot Attribute Master
IV10000 – Unposted/Work Transactions (header)
IV10001 – Unposted/Work Transactions (line detail)
IV10002 – Serial and Lot Number Work
IV10200 – Purchase Receipts (header)
IV10201 – Purchase Receipts Detail (line detail)
IV10300 – Unposted Stock Count (header)
IV10301 – Unposted Stock Count (line detail)
IV30101 – Sales Summary History
IV30102 – Sales Summary Period History

 – Transaction History (header)
IV30300 – Transaction Amounts History (line detail)
IV30301 – Transaction Amounts Detail History
IV30400 – Serial and Lot Number History
IV30500 – Distribution History
IV30600 – Lot Attribute History
IV30700 – Stock Count History (header)
IV30701 – Stock Count Line History (line detail)
IV40400 – Item Class Setup
IV40201 – U of M Schedule Setup (header)
IV40202 – U of M Schedule Detail Setup
IV40600 – Item Category Setup
IV40700 – Site Setup
IV40800 – Price Level Setup



*/


SELECT TRXSORCE,
			CASE DOCTYPE 
                      WHEN 1 THEN 'Ajuste' 
                      ELSE 'Otros' END 'Tipo Doc.',
            DOCNUMBR'Num. Documento',
            DOCDATE'Fecha',
            CUSTNMBR'Id. Cliente',
            IV.ITEMNMBR 'Id. Articulos',
            ITEMDESC'Desc. Articulos',
            UOFM'Unidad Medida',
            TRXQTY 'Cant. Transaccion',
            UNITCOST'Costo Unidad',
            EXTDCOST'Costo Total',
            TRXLOCTN'Localidad',
            '00-113020000-00' Cuenta
                         
FROM IV30300 IV JOIN IV00101 IV1 ON IV.ITEMNMBR=IV1.ITEMNMBR
WHERE IV.IVIVOFIX=33 AND YEAR(DOCDATE)=2015
ORDER BY DOCNUMBR

SELECT * FROM IV30500
WHERE ACTINDX=33
ORDER BY DOCNUMBR

SELECT * FROM IV30300
WHERE IVIVOFIX=33

SELECT * FROM IV10001
WHERE IVIVOFIX=33


