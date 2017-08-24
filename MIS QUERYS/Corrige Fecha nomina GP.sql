--transaciones financiero--
select * from GL20000  
where jrnentry = '1352700'

--Contabilidad Analitica
select * from aag30000
where JRNENTRY = '1352700'


---update transaciones financiero--
/*
update GL20000 
set trxdate = '2011.02.28'
where JRNENTRY = '1352700'
*/

--update Contabilidad Analitica--
/*
update aag30000
set glpostdt = '2011.02.28'
where JRNENTRY = '1352700'
*/

---Luego de esto hay que correr una conciliacion de financiero--