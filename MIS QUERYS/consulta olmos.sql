select a.POPRCTNM, a.ACTINDX, a.CRDTAMNT, a.DEBITAMT ,c.UNITCOST, c.PONUMBER,  c.ITEMNMBR, C.ITEMDESC, c.VNDITDSC, c.UMQTYINB, c.INVINDX,  c.LOCNCODE, b.receiptdate  from POP30390 a join POP30300 b on  a.POPRCTNM = b.POPRCTNM join POP30310 c on  b.POPRCTNM = c.POPRCTNM
---where poprctnm like '%62236'
where c.INVINDX  = '666' and b.receiptdate between '2007.01.01' and '2015.12.31'
--order by a.INVINDX

/*
select * from gl00100
where actnumbr_2 = '121011102'


from iv10301 a join 
iv00101 b on a.itemnmbr = b.itemnmbr

select * from POP30390
where POPRCTNM = 'RCT00000000060021'
*/