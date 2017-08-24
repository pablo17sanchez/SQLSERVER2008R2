     ----Script para que puedas limpiar los recibos de banco.
select * from cm20300
where deposited = 0 and chekbkid = 'UPTOWN TRUST ' and depositnumber = '' 
and receiptdate between '1999.01.01' and '2017.03.01'  AND VOIDED = 0