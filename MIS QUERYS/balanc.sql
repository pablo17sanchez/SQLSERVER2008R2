select
CM.CUSTNMBR Customer_ID, CM.CUSTNAME Customer_Name,
CM.PYMTRMID Customer_Terms, CM.CUSTCLAS Customer_Class,
CM.PRCLEVEL Price_Level,
 
sum(case
when RM.RMDTYPAL < 7 then RM.CURTRXAM
else RM.CURTRXAM * -1
end) Total_Due,
 
sum(case
when DATEDIFF(d, RM.DUEDATE, getdate()) < 30 
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when DATEDIFF(d, RM.DOCDATE, getdate()) < 30 
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [menor_30],
 
sum(case
when DATEDIFF(d, RM.DUEDATE, getdate()) between 31 and 60 
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when DATEDIFF(d, RM.DOCDATE, getdate()) between 31 and 60 
     and RM.RMDTYPAL > 6 then RM.CURTRXAM * -1
else 0
end) [31_to_60_Days],
 
sum(case
when DATEDIFF(d, RM.DUEDATE, getdate()) between 61 and 90 
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when DATEDIFF(d, RM.DOCDATE, getdate()) between 61 and 90 
     and RM.RMDTYPAL > 6 then RM.CURTRXAM * -1
else 0
end) [61_to_90_Days],
 
sum(case
when DATEDIFF(d, RM.DUEDATE, getdate()) between 90 and 120
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when DATEDIFF(d, RM.DOCDATE, getdate()) between 90 and 120
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [91_and_120],
 sum(case
when DATEDIFF(d, RM.DUEDATE, getdate()) between 121 and 150
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when DATEDIFF(d, RM.DOCDATE, getdate()) between 121 and 150
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [121_and_150],

 sum(case
when DATEDIFF(d, RM.DUEDATE, getdate()) between 151 and 180
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when DATEDIFF(d, RM.DOCDATE, getdate()) between 151 and 180
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [151_and_180],

 sum(case
when DATEDIFF(d, RM.DUEDATE, getdate()) >181
     and RM.RMDTYPAL < 7 then RM.CURTRXAM
when DATEDIFF(d, RM.DOCDATE, getdate()) >181
     and RM.RMDTYPAL > 6 then RM.CURTRXAM *-1
else 0
end) [181_and_over],
CS.LASTPYDT Last_Payment_Date,
CS.LPYMTAMT Last_Payment_Amount
 
from RM20101 RM
 
inner join RM00101 CM
     on RM.CUSTNMBR = CM.CUSTNMBR
inner join RM00103 CS
     on RM.CUSTNMBR = CS.CUSTNMBR
 
where RM.VOIDSTTS = 0 and RM.CURTRXAM <> 0 AND RM.CUSTNMBR='10010' AND RM.DOCDATE<='20150930'
 
group by CM.CUSTNMBR, CM.CUSTNAME, CM.PYMTRMID, CM.CUSTCLAS, 
         CM.PRCLEVEL, CS.LASTPYDT,CS.LPYMTAMT
         
         
         
         SELECT * FROM RM20101
         WHERE RMDTYPAL >6 AND CURTRXAM<>0