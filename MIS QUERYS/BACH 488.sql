	    ---1) CODIGO 
		SELECT CUSTNMBR FROM RM10101
		WHERE DOCNUMBR IN(
		
		
		SELECT DOCNUMBR FROM RM20101
		WHERE CUSTNMBR='488' AND BACHNUMB LIKE '%488%' 
		AND DOCDATE BETWEEN '20150801' AND '20150831' AND RMDTYPAL=9)


		--2) LOTE Y CODIGO
		SELECT BACHNUMB,CUSTNMBR FROM RM20101
		WHERE CUSTNMBR='488' AND BACHNUMB LIKE '%488%' AND DOCDATE BETWEEN '20150801' AND '20150831' AND RMDTYPAL=9
		
		--3) LOTE
		SELECT BACHNUMB FROM RM30502
		WHERE BACHNUMB LIKE '%488%' AND right(BACHNUMB,11) BETWEEN '20150801' AND '20150831'
		
		--4) LOTE
		SELECT BACHNUMB FROM SOP30100
		WHERE BACHNUMB LIKE '%488%' AND right(BACHNUMB,11) BETWEEN '20150801' AND '20150831'
		
		---5) LOTE  
		SELECT BACHNUMB FROM SOP30200
		WHERE BACHNUMB LIKE '%0488%' AND right(BACHNUMB,10) BETWEEN '20150801' AND '20150831'
		
		
     

		
		SELECT 'GEA033'
           ,[CODPROD]
           ,[DESCRIP]
           ,[CATEGORIA]
           ,[COSTO]
           ,[PRECIO1]
           ,[PRECIO2]
           ,[PRECIO3]
           ,[EXISTENCIA]
           ,[INVENDIBLE]
           ,[GRAVABLE]
           ,[TAXID]
           ,[PRECMAX]
           ,[PRECMIN] FROM PalmComSync..OUT_PRODUCTO
		WHERE   PALMID='GEA011' 
		
		
		
		SELECT * FROM RM00101
		WHERE CUSTNAME LIKE '%Condominio%'
		
		
		SELECT * FROM vw_VentasGP
		WHERE  CUSTNMBR='26494'