select  year(DateDelivered)AÑO, MONTH(DateDelivered)MES, count(DateDelivered) CANTIDAD_FACTURAS from Invoice

group by year(DateDelivered),MONTH(DateDelivered)
order by year(DateDelivered),MONTH(DateDelivered)


select * from Invoice
WHERE DateDelivered BETWEEN '2008.01.01' AND '2008.12.31'

group by year(DateDelivered)
order by year(DateDelivered)

select MONTH(DateDelivered)MES, count(DateDelivered) CANTIDAD_FACTURAS from Invoice

group by MONTH(DateDelivered)
order by MONTH(DateDelivered)