select  distinct VISTA.VENDORID,VISTA.VENDNAME,
VISTA.RNC_CEDULA,VISTA.AFECTA,VISTA.DOCNUMBR,
VISTA.FECHA,VISTA.FECHA_PAGO,
VISTA.ITBIS_FACTURADO,VISTA.ITBIS_RETENIDO,VISTA.MONTO_FACTURADO,
VISTA.TIPO_BIENES,
VISTA.TIPO_IDENTIFICACION,
VISTA.TRXSORCE,VISTA.VCHRNMBR
,D.ACTNUMBR_1,D.ACTNUMBR_2,D.ACTNUMBR_3,D.DSCRIPTN,D.ORMSTRNM,VISTA.DOCTYPE,d.ACTDESCR
 
 


 from 

 (

select p3.vendorid, p.vendname, 
CASE substring (docnumbr, 10, 2)
WHEN '13' THEN (SELECT TAXREGTN FROM DYNAMICS..SY01500 WHERE CMPANYID = 2)
ELSE p.txrgnnum  END RNC_CEDULA, 
 case when len(p.txrgnnum) = 11 then '2' else '1' end TIPO_IDENTIFICACION,
'09' TIPO_BIENES, 
DOCNUMBR, '                   ' AFECTA, convert(varchar(8), p3.docdate, 112) FECHA,
'        ' FECHA_PAGO, convert(decimal(14,2),p3.TAXAMNT) ITBIS_FACTURADO, 
CAST(0 AS DECIMAL(14,2)) ITBIS_RETENIDO, convert(DECIMAL(14,2),p3.docamnt) MONTO_FACTURADO,
PMPRCHIX ,VCHRNMBR,TRXSORCE,DOCTYPE

from  PM00200 p join PM20000 p3 on (p.vendorid=p3.vendorid AND P3.DOCTYPE = 1)
where year(p3.docdate)=2017 and month(p3.docdate)=4 --and series in (4,12)
and p3.voided = 0 AND TRXSORCE NOT LIKE 'POIVC%' and len (docnumbr) > 15
and substring (docnumbr, 10, 2) IN ('13','01', '04', '11', '05') and docnumbr not like 'TARJETA%'
-----PRIMERA


union all

select p3.vendorid, p.vendname, 
CASE substring (docnumbr, 10, 2)
WHEN '13' THEN (SELECT TAXREGTN FROM DYNAMICS..SY01500 WHERE CMPANYID = 2)
ELSE p.txrgnnum  END RNC_CEDULA,
 case when len(p.txrgnnum) = 11 then '2' else '1' end TIPO_IDENTIFICACION,
'09' TIPO_BIENES, 
DOCNUMBR, '                   ' AFECTA, convert(varchar(8), p3.docdate, 112) FECHA,
'        ' FECHA_PAGO, convert(decimal(14,2),p3.TAXAMNT) ITBIS_FACTURADO, 
CAST(0 AS DECIMAL(14,2)) ITBIS_RETENIDO, convert(DECIMAL(14,2),p3.docamnt) MONTO_FACTURADO,
PMPRCHIX ,VCHRNMBR,TRXSORCE,DOCTYPE


from  PM00200 p join PM30200 p3 on (p.vendorid=p3.vendorid AND P3.DOCTYPE = 1)
where year(p3.docdate)=2017 and month(p3.docdate)=4 --and series in (4,12)
and p3.voided = 0 AND TRXSORCE NOT LIKE 'POIVC%' and len (docnumbr) > 15
and substring (docnumbr, 10, 2) IN ('13', '01', '04', '11', '05') and docnumbr not like 'TARJETA%'
---SEGUNDA 

--union all


--select c0.bankid, bankname, zipcode, case when len(zipcode)= 11 then '2' else '1' end tipo,
--'09' tipo_bienes, cmtrxnum, '                  ', convert(datetime,trxdate,112), '        ',
--cast(0 as decimal(14,2)), cast(0 as decimal(12,2)), cast(trxamnt as decimal(12,2))

--from cm20200 c join cm00100 c0 on (c.chekbkid = c0.chekbkid)
--			   join sy04100 s on (c0.bankid = s.bankid)
--where sourcDoc = 'CMTRX' AND VOIDED = 0
--AND LEN(CMTRXNUM) = 19 and year(trxdate) = 2017 and month(trxdate)=04




union all



select  p3.vendorid, p.vendname, p.txrgnnum RNC_CEDULA, 
 case when len(p.txrgnnum) = 11 then '2' else '1' end TIPO_IDENTIFICACION,
'09' TIPO_BIENES, 
vnddocnm DOCNUMBR, '                   ' AFECTA, convert(varchar(8), p3.receiptdate, 112) FECHA,
'        ' FECHA_PAGO, convert(decimal(14,2),
CASE 
WHEN p3.TAXAMNT - DBO.GetLandedCost(P3.POPRCTNM, p3.TRDISAMT) < 0.05 THEN 0 
ELSE  p3.TAXAMNT - DBO.GetLandedCost(P3.POPRCTNM, p3.TRDISAMT) END) 
ITBIS_FACTURADO, 
CAST(0 AS DECIMAL(14,2)) ITBIS_RETENIDO, convert(DECIMAL(14,2),p3.SubTotal) + 
convert (decimal (14,2),DBO.GetLandedCost(P3.POPRCTNM, p3.TRDISAMT)) MONTO_FACTURADO 
,PMPRCHIX,VCHRNMBR,TRXSORCE,POPTYPE as DOCTYPE
from  PM00200 p join POP30300 p3 on (p.vendorid=p3.vendorid and poptype in (2,3))
where year(p3.receiptdate)=2017 and month(p3.receiptdate)=04 --and series in (4,12)
and p3.voidstts = 0 and len(vnddocnm) > 15 and substring (vnddocnm, 10, 2) 
IN ('13', '01', '04', '11', '05')




) as VISTA


left join (


select ACTDESCR,OPENYEAR,JRNENTRY,
RCTRXSEQ,SOURCDOC,REFRENCE
,DSCRIPTN,TRXDATE,TRXSORCE,
GL20000.ACTINDX,ACTNUMBR_1, ACTNUMBR_2, 
ACTNUMBR_3, POLLDTRX,LASTUSER,
LSTDTEDT,USWHPSTD,ORGNTSRC,
ORGNATYP,QKOFSET,SERIES,ORTRXTYP
,ORCTRNUM,ORMSTRID,ORMSTRNM,
ORDOCNUM,ORPSTDDT,ORTRXSRC,
OrigDTASeries,OrigSeqNum,SEQNUMBR,DTA_GL_Status,DTA_Index,CURNCYID,
CASE WHEN ACCTTYPE = 2 THEN       DECPLACS WHEN ACCTTYPE = 4 THEN 3 ELSE 
CURRNIDX END 'resi',RATETPID,EXGTBLID,XCHGRATE,EXCHDATE,
TIME1,RTCLCMTD,DEBITAMT,CRDTAMNT,ORDBTAMT,ORCRDAMT,GL20000.NOTEINDX,DENXRATE,MCTRXSTT,DOCDATE  from 
GL20000,GL00100 where GL20000.ACTINDX = 
GL00100.ACTINDX)  d 

on    
VISTA.DOCTYPE =d.ORTRXTYP and
VISTA.VCHRNMBR=d.ORCTRNUM 
where VISTA.TRXSORCE not like '%POIVC%'
and d.DEBITAMT >0
and d.DSCRIPTN='Compras'
order by DOCNUMBR









select ACTDESCR, OPENYEAR,JRNENTRY,
RCTRXSEQ,SOURCDOC,REFRENCE
,DSCRIPTN,TRXDATE,TRXSORCE,
GL20000.ACTINDX,ACTNUMBR_1, ACTNUMBR_2, 
ACTNUMBR_3, POLLDTRX,LASTUSER,
LSTDTEDT,USWHPSTD,ORGNTSRC,
ORGNATYP,QKOFSET,SERIES,ORTRXTYP
,ORCTRNUM,ORMSTRID,ORMSTRNM,
ORDOCNUM,ORPSTDDT,ORTRXSRC,ACTDESCR
OrigDTASeries,OrigSeqNum,SEQNUMBR,DTA_GL_Status,DTA_Index,CURNCYID,
CASE WHEN ACCTTYPE = 2 THEN       DECPLACS WHEN ACCTTYPE = 4 THEN 3 ELSE 
CURRNIDX END 'resi',RATETPID,EXGTBLID,XCHGRATE,EXCHDATE,
TIME1,RTCLCMTD,DEBITAMT,CRDTAMNT,ORDBTAMT,ORCRDAMT,GL20000.NOTEINDX,DENXRATE,MCTRXSTT,DOCDATE  from 
GL20000,GL00100 where GL20000.ACTINDX = 
GL00100.ACTINDX and ORCTRNUM='00000000000106754'




select * from GL00100
sele
