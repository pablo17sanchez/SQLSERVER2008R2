SELECT * FROM RM10101 
WHERE POSTEDDT > '2012.12.31' and DSTINDX in(2,33)  and RMDTYPAL = 9
order by DOCNUMBR 

SELECT a.POSTEDDT, a.docnumbr, a.RMDTYPAL, a.CUSTNMBR, b.custclas, a.DSTINDX, a.DEBITAMT, a.CRDTAMNT  FROM RM10101 a join rm00101 b on
a.custnmbr = b.custnmbr
WHERE POSTEDDT between '2013.01.01' and '2013.12.31'  and DSTINDX = 2  and RMDTYPAL = 9 and CUSTCLAS = 'vendedor'
order by DOCNUMBR 

select * from GL00100
where ACTNUMBR_2 = '111010000'

select * from GL00105
where ACTNUMBR_2 = '111010000'

select * from rm00101