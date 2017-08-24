select * from RM10101
where docnumbr = 'ROMA-000000695'


select * from rm20101
where docnumbr = 'ROMA-000000695' 

'ROMA-000000695'

/*
update RM10101
set docnumbr  = 'ROMA-000000695'
where docnumbr  = 'ROMA-000000695'
*/

--TABLA PARA CORREGIR ERROR DE CUADRE DE VENDEDOR
-- RM00301, RM10301, RM20101, RM10201


select * from RM20101
where BACHNUMB = '1638-20140530'

/*
update rm20101
set bachnumb = '4140-20140526'
where DOCNUMBR = 'sani00025880441'
*/
