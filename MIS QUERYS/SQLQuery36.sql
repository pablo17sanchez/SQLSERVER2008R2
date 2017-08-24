select *,'Porcentaje' = SemanaActual  /CASE 
					WHEN UltimaSemana = 0 THEN SemanaActual  
					ELSE UltimaSemana 
					END  -1 from vw_ventas_promediosemanal
WHERE SemanaActual/UltimaSemana <-0.10 and SemanaActual/UltimaSemana >0.10

(cast(semana1 as decimal(15,4)) / 
                    case when semana2 = 0 then cast(semana1 as decimal(15,4))					else cast(semana2 as decimal(15,4)) end)-1
