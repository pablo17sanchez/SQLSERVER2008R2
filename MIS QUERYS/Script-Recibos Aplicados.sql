select docnumber,docap,docdate,datediff(day,DOCDATE,GETDATE()) Antiguedad from dbo.vw_DocAplicadoGP
where docnumber = ' RC00696517  '
order by docdate

select  bachnumb,docnumbr,custnmbr,docdate,[CashReceiptType],cheknmbr,[Comment],ortrxamt from 
(select bachnumb,docnumbr,custnmbr,docdate,cshrctyp [CashReceiptType],cheknmbr,trxdscrn[Comment],ortrxamt from rm10201
where rmdtypal = 9
union
select bachnumb,docnumbr,custnmbr,docdate,cshrctyp [CashReceiptType],cheknmbr,trxdscrn[Comment],ortrxamt from rm20101
where rmdtypal = 9)RC

Select custnmbr,aptodcdt,aptodcnm,oraptoam,apfrdcnm,apfrdcdt from rm20201
where apfrdcty = 9
union
Select custnmbr,aptodcdt,aptodcnm,oraptoam,apfrdcnm,apfrdcdt from rm30201
where apfrdcty = 9

