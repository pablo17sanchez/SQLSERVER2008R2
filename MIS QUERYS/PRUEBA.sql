USE [GPHN]
GO

/****** Object:  View [dbo].[prueba]    Script Date: 02/28/2017 09:10:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[prueba] 


as 



SELECT     sp1.PRCLEVEL, sp1.BACHNUMB, sp1.DOCAMNT, sp1.USER2ENT, sp1.DOCID, sp1.CUSTNMBR, sp1.CUSTNAME, sp1.SOPNUMBE, sp1.DOCDATE, 
                                              sp1.SLPRSNID, sp2.ITEMNMBR, sp2.ITEMDESC, sp1.LOCNCODE, sp2.UNITPRCE, sp2.UNITCOST, sp2.QUANTITY, sp2.XTNDPRCE, sp1.PYMTRMID, 
                                              sp1.VOIDSTTS, sp1.PYMTRCVD, sp1.SOPTYPE, SP1.GLPOSTDT
                       FROM          dbo.SOP10100 AS sp1 INNER JOIN
                                              dbo.SOP10200 AS sp2 ON sp1.SOPNUMBE = sp2.SOPNUMBE
                       WHERE      (sp1.SOPTYPE IN(2))  
                       UNION ALL
                       SELECT     sp3.PRCLEVEL, sp3.BACHNUMB, sp3.DOCAMNT, sp3.USER2ENT, sp3.DOCID, sp3.CUSTNMBR, sp3.CUSTNAME, sp3.SOPNUMBE, sp3.DOCDATE, 
                                             sp3.SLPRSNID, sp4.ITEMNMBR, sp4.ITEMDESC, sp3.LOCNCODE, sp4.UNITPRCE, sp4.UNITCOST, sp4.QUANTITY, sp4.XTNDPRCE, sp3.PYMTRMID, 
                                             sp3.VOIDSTTS, sp3.PYMTRCVD, sp3.SOPTYPE, SP3.GLPOSTDT
                       FROM         dbo.SOP30200 AS sp3 INNER JOIN
                                             dbo.SOP30300 AS sp4 ON sp3.SOPNUMBE = sp4.SOPNUMBE
                       WHERE     sp3.SOPTYPE IN(2) 
GO


