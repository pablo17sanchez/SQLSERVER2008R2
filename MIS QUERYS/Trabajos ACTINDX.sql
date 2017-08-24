select * from sop10200
where SOPNUMBE = '00622109'

/*
select * from AAG00200
order by ACTINDX
*/

select * from sop10200
where SOPNUMBE = '00506549' and itemnmbr = 'pt100'

/*

---update actindx ventas----
update sop10200
set slsindx = ''
where SOPNUMBE = '00622109'
*/

/*
---update actindx costo----
update sop10200
set cslsindx = ''
where SOPNUMBE = '00622109'

*/
---update actindx ventas----
/*
update sop10200
set slsindx = '709', cslsindx = '710'
where SOPNUMBE = '00506549' and itemnmbr = 'pt100'
*/

---update actindx costo----
/*
update sop10200
set cslsindx = '702'
where SOPNUMBE = '10081060100181882' and itemnmbr = 'pt400'