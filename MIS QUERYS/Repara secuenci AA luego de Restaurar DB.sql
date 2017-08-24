if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagUpdateAAG00102]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagUpdateAAG00102]
GO

/*-------------------------------------------------------------------------------------
### Updating the values in the DYNAMICS..AAG00102 table
--------------------------------------------------------------------------------------*/
create     procedure aagUpdateAAG00102
as
begin
	set nocount on	
	declare @CMPANYID	smallint,
		@maxValue	int

	select	@maxValue = 0
	select  distinct @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()

	select @maxValue = max(aaGLHdrID) from AAG30000
	if @maxValue > 0
		update DYNAMICS..AAG00102 set aaRowID = @maxValue where aaTableID = 30000 and CMPANYID = @CMPANYID
	select @maxValue = max(aaSubLedgerHdrID) from AAG20000
	if @maxValue > 0
		update DYNAMICS..AAG00102 set aaRowID = @maxValue where aaTableID = 20000 and CMPANYID = @CMPANYID
	select @maxValue = max(aaGLWorkHdrID) from AAG10000
	if @maxValue > 0
		update DYNAMICS..AAG00102 set aaRowID = @maxValue where aaTableID = 10000 and CMPANYID = @CMPANYID
	set nocount off	
end
GO

exec aagUpdateAAG00102
drop procedure aagUpdateAAG00102

/*-------------------------------------------------------------------------------------
### Droping the existing TOD procedures.
--------------------------------------------------------------------------------------*/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODglOpen]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODglOpen]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODglHist]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODglHist]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODrm]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODrm]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODpm]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODpm]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODglWork]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODglWork]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODsop]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODsop]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODpop]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODpop]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODcmDist]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODcmDist]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[aagTODiv]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[aagTODiv]
GO

/*-------------------------------------------------------------------------------------
#230 aagTODglOpen
--------------------------------------------------------------------------------------*/
create     procedure aagTODglOpen
	@caaTrxSource	char(13)
as
	/*This procedure will create distribution for all the existing distribution available in GL Open.
		v-villaw	date:08-07-2004			Initial implementation*/
begin
	set nocount on	
	declare @CMPANYID	smallint,
		@aagGetHdrID	int,
		@Status		int,
		@JRNENTRY	int,
		@RCTRXSEQ	numeric(19,5),
		@OPENYEAR	int,
		@TRXSORCE	char(13),
		@TRXDATE	datetime
	
	select  @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()
	
	exec DYNAMICS..aagGetNextID 30000, @CMPANYID, @aagGetHdrID out, @Status

	declare CGLOPEN cursor for 
		select JRNENTRY, RCTRXSEQ,OPENYEAR,TRXSORCE,TRXDATE
			from GL20000 where SOURCDOC <> 'BBF'
			group by OPENYEAR,JRNENTRY,RCTRXSEQ,TRXSORCE,TRXDATE
	open CGLOPEN 
	fetch next from CGLOPEN	into @JRNENTRY,@RCTRXSEQ,@OPENYEAR,@TRXSORCE,@TRXDATE
	while @@fetch_status =0
	begin
		insert into AAG30000
			(aaGLHdrID,JRNENTRY,RCTRXSEQ,YEAR1,aaTRXType,aaGLTRXSource,aaTRXSource,GLPOSTDT)
			values(dbo.aagGetNextHdrID(30000),@JRNENTRY,@RCTRXSEQ,@OPENYEAR,1,@TRXSORCE,' ',@TRXDATE)
		
		fetch next from CGLOPEN	into @JRNENTRY,@RCTRXSEQ,@OPENYEAR,@TRXSORCE,@TRXDATE
	end	
	close CGLOPEN
	deallocate CGLOPEN
	
	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(30000) - 1
		where aaTableID = 30000 and CMPANYID = @CMPANYID
	
	insert into AAG30001 
		(aaGLHdrID,  aaGLDistID, INTERID , CorrespondingUnit, ACTINDX, ACCTTYPE ,
		aaBrowseType, DECPLACS, DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT,
		CURNCYID, CURRNIDX, RATETPID, EXGTBLID, XCHGRATE, EXCHDATE, TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT, SEQNUMBR, 
		aaCustID, aaVendID, aaSiteID, aaItemID, aaCopyStatus)
		select dbo.aagGetHdrID(0,1,' ',' ',JRNENTRY,RCTRXSEQ, TRXDATE,OPENYEAR,TRXSORCE,30000),
		DEX_ROW_ID,
		DB_NAME() ,CorrespondingUnit,ACTINDX, 0,
		0,2,  DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT,
		CURNCYID, CURRNIDX, RATETPID,  EXGTBLID, XCHGRATE, EXCHDATE,TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT, SEQNUMBR,0,
		0, 0, 0, 8 from GL20000 where SOURCDOC <> 'BBF'		
	
	set nocount off
end
GO

/*-------------------------------------------------------------------------------------
#231 aagTODglHist
--------------------------------------------------------------------------------------*/
create     procedure aagTODglHist
	@caaTrxSource	char(13)
as
	/*This procedure will create distribution for all the existing distribution available in GL Open.
		v-villaw	date:08-07-2004			Initial implementation*/
begin
	set nocount on	
	declare @CMPANYID	smallint,
		@aagGetHdrID	int,
		@Status		int,
		@JRNENTRY	int,
		@RCTRXSEQ	numeric(19,5),
		@HSTYEAR	int,
		@TRXSORCE	char(13),
		@TRXDATE	datetime
	
	select  @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()
	
	exec DYNAMICS..aagGetNextID 30000, @CMPANYID, @aagGetHdrID out, @Status

	declare CGLOPEN cursor for 
		select JRNENTRY, RCTRXSEQ,HSTYEAR,TRXSORCE,TRXDATE
			from GL30000 where SOURCDOC <> 'BBF'
			group by HSTYEAR,JRNENTRY,RCTRXSEQ,TRXSORCE,TRXDATE
	open CGLOPEN 
	fetch next from CGLOPEN	into @JRNENTRY,@RCTRXSEQ,@HSTYEAR,@TRXSORCE,@TRXDATE
	while @@fetch_status =0
	begin
		insert into AAG30000
			(aaGLHdrID,JRNENTRY,RCTRXSEQ,YEAR1,aaTRXType,aaGLTRXSource,aaTRXSource,GLPOSTDT)
			values(dbo.aagGetNextHdrID(30000),@JRNENTRY,@RCTRXSEQ,@HSTYEAR,1,@TRXSORCE,' ',@TRXDATE)
		
		fetch next from CGLOPEN	into @JRNENTRY,@RCTRXSEQ,@HSTYEAR,@TRXSORCE,@TRXDATE
	end	
	close CGLOPEN
	deallocate CGLOPEN
	
	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(30000) - 1
		where aaTableID = 30000 and CMPANYID = @CMPANYID
	
	insert into AAG30001 
		(aaGLHdrID,  aaGLDistID, INTERID , CorrespondingUnit, ACTINDX, ACCTTYPE ,
		aaBrowseType, DECPLACS, DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT,
		CURNCYID, CURRNIDX, RATETPID, EXGTBLID, XCHGRATE, EXCHDATE, TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT, SEQNUMBR, 
		aaCustID, aaVendID, aaSiteID, aaItemID, aaCopyStatus)
		select dbo.aagGetHdrID(0,1,' ',' ',JRNENTRY,RCTRXSEQ, TRXDATE,HSTYEAR,TRXSORCE,30000),
		DEX_ROW_ID,
		DB_NAME() ,CorrespondingUnit,ACTINDX, 0,
		0,2,  DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT,
		CURNCYID, CURRNIDX, RATETPID,  EXGTBLID, XCHGRATE, EXCHDATE,TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT, SEQNUMBR,0,
		0, 0, 0, 8 from GL30000 where SOURCDOC <> 'BBF'
		
	insert into AAG30002
		(aaGLHdrID,aaGLDistID,aaGLAssignID,DEBITAMT,CRDTAMNT,ORDBTAMT,ORCRDAMT,aaAssignedPercent,
		DistRef,NOTEINDX)
		select aaGLHdrID,aaGLDistID,1,DEBITAMT,CRDTAMNT,ORDBTAMT,ORCRDAMT,10000,
		' ',0 from AAG30001 	
	
	set nocount off
end
GO

/*-------------------------------------------------------------------------------------
#232 aagTODrm
--------------------------------------------------------------------------------------*/
create  procedure aagTODrm
	@SqlSessionID int
as
	/*This procedure will create distribution for all the existing distribution available in RM.
		v-villaw	date:08-07-2004			Initial implementation*/
begin
	set nocount on
	declare @aagGetHdrID	int,
		@Status		int,		
		@CMPANYID    	int,
		@DOCTYPE	int,
		@DOCNUMBR	char(21)
	
	select  @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()

	exec DYNAMICS..aagGetNextID 20000, @CMPANYID, @aagGetHdrID out, @Status
		
	declare CRM cursor for
		select RMDTYPAL,DOCNUMBR
			from RM00401
	open CRM
	fetch next from CRM into @DOCTYPE,@DOCNUMBR
	while @@fetch_status = 0
	begin
		insert into AAG20000
			(aaSubLedgerHdrID,SERIES,DOCTYPE,DOCNUMBR,Master_ID,aaHdrErrors)
			values(dbo.aagGetNextHdrID(20000),3,@DOCTYPE,@DOCNUMBR,' ',0)

		fetch next from CRM into @DOCTYPE,@DOCNUMBR
	end
	close CRM
	deallocate CRM
	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(20000) - 1
		where aaTableID = 20000 and CMPANYID = @CMPANYID

	insert into AAG20001
		(aaSubLedgerHdrID, 
		aaSubLedgerDistID, 
		INTERID, ACTINDX, DISTTYPE, aaBrowseType,
		DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT, CURNCYID, CURRNIDX, SEQNUMBR,
		GLPOSTDT, aaCustID, POSTED ,RATETPID, EXGTBLID, XCHGRATE, EXCHDATE, TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT)				
		select dbo.aagGetHdrID(3,RM10101.RMDTYPAL,RM10101.DOCNUMBR,' ',0,0, getdate(),0,' ',20000),
		RM10101.DEX_ROW_ID,
		DB_NAME(), RM10101.DSTINDX, RM10101.DISTTYPE, 0,
		RM10101.DEBITAMT, RM10101.CRDTAMNT, RM10101.ORDBTAMT, RM10101.ORCRDAMT, isnull(RM10101.CURNCYID,' '), isnull(MC020102.CURRNIDX,0), RM10101.SEQNUMBR as SEQNUMBR,
		RM10101.POSTEDDT, 0, RM10101.POSTED, isnull(MC020102.RATETPID,' '), isnull(MC020102.EXGTBLID,' '), isnull(MC020102.XCHGRATE,0), isnull(MC020102.EXCHDATE,'1999-03-06 00:00:00.000'), isnull(MC020102.TIME1,0),
		isnull(MC020102.RTCLCMTD,0), isnull(MC020102.DENXRATE,0), isnull(MC020102.MCTRXSTT,0) from MC020102 RIGHT OUTER JOIN
                RM10101 ON MC020102.RMDTYPAL = RM10101.RMDTYPAL AND MC020102.DOCNUMBR = RM10101.DOCNUMBR
		union all
		select dbo.aagGetHdrID(3,RM30301.RMDTYPAL,RM30301.DOCNUMBR,' ',0,0, getdate(),0,'',20000),
		RM30301.DEX_ROW_ID,
		DB_NAME(), RM30301.DSTINDX, RM30301.DISTTYPE, 0,
		RM30301.DEBITAMT, RM30301.CRDTAMNT, RM30301.ORDBTAMT, RM30301.ORCRDAMT, isnull(RM30301.CURNCYID,' '), isnull(MC020102.CURRNIDX,0), RM30301.SEQNUMBR as SEQNUMBR,
		RM30301.POSTEDDT, 0, 1, isnull(MC020102.RATETPID,' '), isnull(MC020102.EXGTBLID,' '), isnull(MC020102.XCHGRATE,0), isnull(MC020102.EXCHDATE,'1999-03-06 00:00:00.000'), isnull(MC020102.TIME1,0),
		isnull(MC020102.RTCLCMTD,0), isnull(MC020102.DENXRATE,0), isnull(MC020102.MCTRXSTT,0) from MC020102 RIGHT OUTER JOIN
                RM30301 ON MC020102.RMDTYPAL = RM30301.RMDTYPAL AND MC020102.DOCNUMBR = RM30301.DOCNUMBR

	insert into AAG20002 
		(aaSubLedgerHdrID,aaSubLedgerDistID,aaSubLedgerAssignID,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,aaAssignedPercent,DistRef,NOTEINDX,aaAssignErrors)
		select aaSubLedgerHdrID,aaSubLedgerDistID,1,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,10000,' ',0,0 from AAG20001 where aaSubLedgerHdrID in
		(select aaSubLedgerHdrID from AAG20000 where SERIES = 3)

	set nocount off
end 
GO

/*-------------------------------------------------------------------------------------
#234 aagTODpm
--------------------------------------------------------------------------------------*/
create           procedure aagTODpm
	@SqlSessionID int
as
	/*This procedure will create distribution for all the existing distribution available in PM.
		v-villaw	date:08-07-2004			Initial implementation*/
begin
	set nocount on
	declare @CMPANYID	smallint,
		@Hdr		int,
		@CNTRLTYP	int,
		@VCHRNMBR	char(21)
		
	select @Hdr		=0

	select  @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()
	
	declare CPM cursor for
		select CNTRLTYP,VCHRNMBR
			from PM10100
			group by CNTRLTYP,VCHRNMBR
		union all
		select CNTRLTYP,VCHRNMBR
			from PM30600
			group by CNTRLTYP,VCHRNMBR
	open CPM
	fetch next from CPM into @CNTRLTYP,@VCHRNMBR
	while @@fetch_status = 0
	begin
		insert into AAG20000
			(aaSubLedgerHdrID,SERIES,DOCTYPE,DOCNUMBR,Master_ID,aaHdrErrors)
			values(dbo.aagGetNextHdrID(20000),4,@CNTRLTYP,@VCHRNMBR,' ',0)
		fetch next from CPM into @CNTRLTYP,@VCHRNMBR
	end
	close CPM
	deallocate CPM	
	
	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(20000) - 1
		where aaTableID = 20000 and CMPANYID = @CMPANYID

	insert into AAG20001
		(aaSubLedgerHdrID, aaSubLedgerDistID, INTERID, ACTINDX, DISTTYPE, aaBrowseType,
		DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT, CURNCYID, CURRNIDX, SEQNUMBR,
		GLPOSTDT, aaCustID, POSTED ,RATETPID, EXGTBLID, XCHGRATE, EXCHDATE, TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT)				
		select dbo.aagGetHdrID(4,CNTRLTYP,VCHRNMBR,' ',0,0, getdate(),0,' ',20000),
		DEX_ROW_ID,
		DB_NAME(), DSTINDX, DISTTYPE, 0,
		DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT, isnull(CURNCYID,' '), isnull(CURRNIDX,0), DSTSQNUM,
		PSTGDATE, 0, 0, isnull(RATETPID,' '), isnull(EXGTBLID,' '), isnull(XCHGRATE,0), isnull(EXCHDATE,'1999-03-06 00:00:00.000'), isnull(TIME1,0),
		isnull(RTCLCMTD,0), isnull(DENXRATE,0), isnull(MCTRXSTT,0) from PM10100		
		union all
		select dbo.aagGetHdrID(4,PM30600.CNTRLTYP,PM30600.VCHRNMBR,' ',0,0, getdate(),0,' ',20000),
		PM30600.DEX_ROW_ID,
		DB_NAME(), PM30600.DSTINDX, PM30600.DISTTYPE, 0,
		PM30600.DEBITAMT, PM30600.CRDTAMNT, PM30600.ORDBTAMT, PM30600.ORCRDAMT, isnull(MC020103.CURNCYID,' '), isnull(MC020103.CURRNIDX,0), PM30600.DSTSQNUM,
		PM30600.PSTGDATE, 1, 0, isnull(MC020103.RATETPID,' '), isnull(MC020103.EXGTBLID,' '), isnull(MC020103.XCHGRATE,0), isnull(MC020103.EXCHDATE,'1999-03-06 00:00:00.000'), isnull(MC020103.TIME1,0),
		isnull(MC020103.RTCLCMTD,0), isnull(MC020103.DENXRATE,0), isnull(MC020103.MCTRXSTT,0) from  PM30600 LEFT OUTER JOIN
                MC020103 on PM30600.CNTRLTYP = MC020103.DOCTYPE and
		PM30600.VCHRNMBR = MC020103.VCHRNMBR 
			
	insert into AAG20002 	
		(aaSubLedgerHdrID,aaSubLedgerDistID,aaSubLedgerAssignID,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,aaAssignedPercent,DistRef,NOTEINDX,aaAssignErrors)
		select aaSubLedgerHdrID,aaSubLedgerDistID,1,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,10000,' ',0,0 from AAG20001 where aaSubLedgerHdrID in
		(select aaSubLedgerHdrID from AAG20000 where SERIES = 4)
		
	set nocount off
end
GO

/*-------------------------------------------------------------------------------------
#235 aagTODglWork
--------------------------------------------------------------------------------------*/
create      procedure aagTODglWork
	@caaTrxSource	char(13)
as
begin
	set nocount on	
	declare @CMPANYID	int,
		@aagGetHdrID	int,
		@Status		int,
		@JRNENTRY	int,
		@RCTRXSEQ	numeric(19,5),
		@TRXDATE	datetime

	
	select  @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()

	exec DYNAMICS..aagGetNextID 10000, @CMPANYID, @aagGetHdrID out, @Status

	declare CGLWork cursor for	
	select JRNENTRY,RCTRXSEQ,TRXDATE
		from GL10000
	open CGLWork
	fetch next from CGLWork into @JRNENTRY,@RCTRXSEQ,@TRXDATE
	while @@fetch_status = 0
	begin
		insert into AAG10000
			(aaGLWorkHdrID,JRNENTRY,RCTRXSEQ,GLPOSTDT,aaTRXType,aaHdrErrors)
			values(dbo.aagGetNextHdrID(10000),@JRNENTRY,@RCTRXSEQ,@TRXDATE,1,0)
		fetch next from CGLWork into @JRNENTRY,@RCTRXSEQ,@TRXDATE
	end
	close CGLWork
	deallocate CGLWork	
	
	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(10000) - 1
		where aaTableID = 10000 and CMPANYID = @CMPANYID

	insert into AAG10001 
		(aaGLWorkHdrID,  aaGLWorkDistID, INTERID , CorrespondingUnit, ACTINDX, ACCTTYPE ,
		aaBrowseType, DECPLACS, FXDORVAR, DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT,
		CURNCYID, CURRNIDX, RATETPID, EXGTBLID, XCHGRATE, EXCHDATE, TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT, SQNCLINE, 
		aaCustID, aaVendID, aaSiteID, aaItemID, aaCopyStatus, aaWinWasOpen, aaOFFSETAcct, aaDistErrors )
		select dbo.aagGetHdrID(0,1,' ',' ',GL10000.JRNENTRY,GL10000.RCTRXSEQ, getdate(),0,' ',10000),
		GL10001.DEX_ROW_ID,
		INTERID ,CorrespondingUnit,ACTINDX, ACCTTYPE,
		0,2, 0	, DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT,
		GL10000.CURNCYID, GL10000.CURRNIDX, GL10001.RATETPID,  GL10001.EXGTBLID, GL10001.XCHGRATE, GL10001.EXCHDATE, GL10001.TIME1,
		GL10001.RTCLCMTD, GL10001.DENXRATE, GL10001.MCTRXSTT, GL10001.SQNCLINE,0,
		0, 0, 0, 8, 0, 0, 0 from GL10000 , GL10001 
		where GL10001.JRNENTRY = GL10000.JRNENTRY
		
	insert into AAG10002
		(aaGLWorkHdrID,aaGLWorkDistID,aaGLWorkAssignID,DEBITAMT,CRDTAMNT,ORDBTAMT,ORCRDAMT,
		aaAssignedPercent,DistRef,NOTEINDX,aaAssignErrors)
		select aaGLWorkHdrID,aaGLWorkDistID,1,DEBITAMT,CRDTAMNT,ORDBTAMT,ORCRDAMT,
		10000,' ',0,0
		from AAG10001

	set nocount off
end
GO

/*-------------------------------------------------------------------------------------
#236 aagTODsop
--------------------------------------------------------------------------------------*/
create       procedure aagTODsop
	@SqlSessionID int
as
	/*This procedure will create distribution for all the existing distribution available in SOP.
		v-villaw	date:08-07-2004			Initial implementation*/

begin
	set nocount on
	
	declare	@CMPANYID	int,
		@HdrID		int,
		@DOCTYPE	int,
		@DOCNUMBR	char(21)	

	select @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()
	
	select @HdrID = dbo.aagGetNextHdrID(20000) - 1

	declare CSOP cursor for
		select SOPTYPE,SOPNUMBE 
			from SOP10100
		union all
		select SOPTYPE,SOPNUMBE
			from SOP30200
	open CSOP
	fetch next from CSOP into @DOCTYPE,@DOCNUMBR
	while @@fetch_status = 0
	begin
		insert into AAG20000
			(aaSubLedgerHdrID,SERIES,DOCTYPE,DOCNUMBR,Master_ID,aaHdrErrors)
			values(dbo.aagGetNextHdrID(20000),11,@DOCTYPE,@DOCNUMBR,' ',0)

		fetch next from CSOP into @DOCTYPE,@DOCNUMBR
	end
	close CSOP
	deallocate CSOP
	
	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(20000) - 1
		where aaTableID = 20000 and CMPANYID = @CMPANYID

	insert into AAG20001
		(aaSubLedgerHdrID, 
		aaSubLedgerDistID, 
		INTERID, ACTINDX, DISTTYPE, aaBrowseType,
		DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT, CURNCYID, CURRNIDX, SEQNUMBR,
		GLPOSTDT, aaCustID, POSTED ,RATETPID, EXGTBLID, XCHGRATE, EXCHDATE, TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT)				
		select dbo.aagGetHdrID(11,SOP10102.SOPTYPE,SOP10102.SOPNUMBE,' ',0,0, getdate(),0,' ',20000),
		SOP10102.DEX_ROW_ID, 
		DB_NAME(), SOP10102.ACTINDX,SOP10102.DISTTYPE, 0, 
		SOP10102.DEBITAMT, SOP10102.CRDTAMNT, SOP10102.ORDBTAMT, SOP10102.ORCRDAMT, SOP10100.CURNCYID, SOP10100.CURRNIDX, SOP10102.SEQNUMBR,
		SOP10100.DOCDATE, 0, SOP10102.POSTED ,SOP10100.RATETPID, SOP10100.EXGTBLID, SOP10100.XCHGRATE, SOP10100.EXCHDATE, SOP10100.TIME1,
		SOP10100.RTCLCMTD, SOP10100.DENXRATE, SOP10100.MCTRXSTT
		from SOP10102, SOP10100
		where SOP10102.SOPTYPE = SOP10100.SOPTYPE and
		SOP10102.SOPNUMBE = SOP10100.SOPNUMBE
		union all
		select dbo.aagGetHdrID(11,SOP10102.SOPTYPE,SOP10102.SOPNUMBE,' ',0,0, getdate(),0,' ',20000),
		SOP10102.DEX_ROW_ID, 
		DB_NAME(), SOP10102.ACTINDX,SOP10102.DISTTYPE, 0, 
		SOP10102.DEBITAMT, SOP10102.CRDTAMNT, SOP10102.ORDBTAMT, SOP10102.ORCRDAMT, SOP30200.CURNCYID, SOP30200.CURRNIDX, SOP10102.SEQNUMBR,
		SOP30200.DOCDATE, 0, SOP10102.POSTED ,SOP30200.RATETPID, SOP30200.EXGTBLID, SOP30200.XCHGRATE, SOP30200.EXCHDATE, SOP30200.TIME1,
		SOP30200.RTCLCMTD, SOP30200.DENXRATE, SOP30200.MCTRXSTT
		from SOP10102, SOP30200
		where SOP10102.SOPTYPE = SOP30200.SOPTYPE and
		SOP10102.SOPNUMBE = SOP30200.SOPNUMBE
		
	insert into AAG20002 
		(aaSubLedgerHdrID,aaSubLedgerDistID,aaSubLedgerAssignID,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,aaAssignedPercent,DistRef,NOTEINDX,aaAssignErrors)
		select aaSubLedgerHdrID,aaSubLedgerDistID,1,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,10000,' ',0,0 from AAG20001 where aaSubLedgerHdrID in
		(select aaSubLedgerHdrID from AAG20000 where SERIES = 11)
	set nocount off
end
GO

/*-------------------------------------------------------------------------------------
#237 aagTODpop
--------------------------------------------------------------------------------------*/
create     procedure aagTODpop
	@SqlSessionID int
as
	/*This procedure will create distribution for all the existing distribution available in POP.
		v-villaw	date:08-07-2004			Initial implementation*/
begin
	set nocount on
	declare @CMPANYID	int,
		@HdrID		int,
		@DOCTYPE	int,
		@DOCNUMBR	char(21)

	select  @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()

	declare CPOP cursor for 
		select POPTYPE,POPRCTNM
			from POP10300 
		union all 
		select POPTYPE,POPRCTNM 
			from POP30300
	open CPOP
	fetch next from CPOP into @DOCTYPE,@DOCNUMBR
	while @@fetch_status = 0
	begin
		insert into AAG20000
			(aaSubLedgerHdrID,SERIES,DOCTYPE,DOCNUMBR,Master_ID,aaHdrErrors)
			values(dbo.aagGetNextHdrID(20000),12,@DOCTYPE,@DOCNUMBR,' ',0)
		fetch next from CPOP into @DOCTYPE,@DOCNUMBR
	end
	close CPOP
	deallocate CPOP	
	
	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(20000) - 1
		where aaTableID = 20000 and CMPANYID = @CMPANYID

	insert into AAG20001 
		(aaSubLedgerHdrID, aaSubLedgerDistID, INTERID, ACTINDX, DISTTYPE, aaBrowseType, 
		DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT, CURNCYID, CURRNIDX, SEQNUMBR,
		GLPOSTDT, aaCustID, POSTED ,RATETPID, EXGTBLID, XCHGRATE, EXCHDATE, TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT)
		select dbo.aagGetHdrID(12,POP10300.POPTYPE,POP10300.POPRCTNM,' ',0,0, getdate(),0,' ',20000),
		POP10390.DEX_ROW_ID,
 		DB_NAME(), POP10390.ACTINDX, POP10390.DISTTYPE, 0, 
		POP10390.DEBITAMT, POP10390.CRDTAMNT, POP10390.ORDBTAMT, POP10390.ORCRDAMT, isnull(POP10390.CURNCYID,' '), POP10390.CURRNIDX, POP10390.SEQNUMBR,
		POP10300.GLPOSTDT, 0, 1, isnull(POP10390.RATETPID,' '), isnull(POP10390.EXGTBLID,' '), POP10390.XCHGRATE, POP10390.EXCHDATE, POP10390.TIME1, 
		POP10390.RATECALC, POP10390.DENXRATE, POP10390.MCTRXSTT 
		from POP10390, POP10300 where POP10390.POPRCTNM = POP10300.POPRCTNM
		union all
		select dbo.aagGetHdrID(12,POP30300.POPTYPE,POP30300.POPRCTNM,' ',0,0, getdate(),0,' ',20000),
		POP30390.DEX_ROW_ID,
 		DB_NAME(), POP30390.ACTINDX, POP30390.DISTTYPE, 0, 
		POP30390.DEBITAMT, POP30390.CRDTAMNT, POP30390.ORDBTAMT, POP30390.ORCRDAMT, isnull(POP30390.CURNCYID,' '), POP30390.CURRNIDX, POP30390.SEQNUMBR,
		POP30300.GLPOSTDT, 0, 1, isnull(POP30390.RATETPID,' '), isnull(POP30390.EXGTBLID,' '), POP30390.XCHGRATE, POP30390.EXCHDATE, POP30390.TIME1, 
		POP30390.RATECALC, POP30390.DENXRATE, POP30390.MCTRXSTT 
		from POP30390, POP30300 where POP30390.POPRCTNM = POP30300.POPRCTNM

	insert into AAG20002 
		(aaSubLedgerHdrID,aaSubLedgerDistID,aaSubLedgerAssignID,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,aaAssignedPercent,DistRef,NOTEINDX,aaAssignErrors)
		select aaSubLedgerHdrID,aaSubLedgerDistID,1,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,10000,' ',0,0 from AAG20001 where aaSubLedgerHdrID in
		(select aaSubLedgerHdrID from AAG20000 where SERIES = 12)

	set nocount off
end
GO

/*-------------------------------------------------------------------------------------
#238 aagTODcmDist
--------------------------------------------------------------------------------------*/
create     procedure aagTODcmDist
	@SqlSessionID int
as
	/*This procedure will create distribution for all the existing distribution available in CM.
		v-villaw	date:08-07-2004			Initial implementation*/
begin	
	set nocount on

	declare @CMPANYID	int,
		@HdrID		int,
		@CMTrxType	int,
		@CMTrxNum	char(21),
		@CHEKBKID	char(15)


		
	select  @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()

	declare CCM cursor for 
	select CMTrxType,CMTrxNum,CHEKBKID
		from CM20200
		where CMRECNUM in (select CMDNUMWK from CM20400)
		group by CMTrxType,CMTrxNum,CHEKBKID
	open CCM
	fetch next from CCM into @CMTrxType,@CMTrxNum,@CHEKBKID
	while @@fetch_status = 0
	begin
		insert into AAG20000
			(aaSubLedgerHdrID,SERIES,DOCTYPE,DOCNUMBR,Master_ID,aaHdrErrors)
			values(dbo.aagGetNextHdrID(20000),2,@CMTrxType,@CMTrxNum,@CHEKBKID,0)
		fetch next from CCM into @CMTrxType,@CMTrxNum,@CHEKBKID
	end
	close CCM
	deallocate CCM

	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(20000) - 1
		where aaTableID = 20000 and CMPANYID = @CMPANYID
			
	insert into AAG20001
		(aaSubLedgerHdrID, 
		aaSubLedgerDistID, 
		INTERID, ACTINDX, DISTTYPE, aaBrowseType, 
		DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT, CURNCYID, CURRNIDX, SEQNUMBR,
		GLPOSTDT, aaCustID, POSTED ,RATETPID, EXGTBLID, XCHGRATE, EXCHDATE, TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT)		
		select dbo.aagGetHdrID(2,CM20200.CMTrxType,CM20200.CMTrxNum,CM20200.CHEKBKID,0,0, getdate(),0,' ',20000),
		CM20400.DEX_ROW_ID,
		DB_NAME(), ACTINDX, 0, 0, 
		DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT, isnull(CURNCYID,' '), isnull(CURRNIDX,0), DSTSQNUM,
		clearedate, 0, 0, isnull(RATETPID,' '), isnull(EXGTBLID,' '), isnull(XCHGRATE,0), isnull(EXCHDATE,'1999-03-06 00:00:00.000'), isnull(TIME1,0), 
		isnull(RTCLCMTD,0), isnull(DENXRATE,0), isnull(MCTRXSTT,0)
		from CM20400,CM20200 where CM20200.CMRECNUM = CM20400.CMDNUMWK

	insert into AAG20002 
		(aaSubLedgerHdrID,aaSubLedgerDistID,aaSubLedgerAssignID,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,aaAssignedPercent,DistRef,NOTEINDX,aaAssignErrors)
		select aaSubLedgerHdrID,aaSubLedgerDistID,1,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,10000,' ',0,0 from AAG20001 where aaSubLedgerHdrID in
		(select aaSubLedgerHdrID from AAG20000 where SERIES = 2)		

	set nocount off	
end
GO

/*-------------------------------------------------------------------------------------
#240 aagTODiv
--------------------------------------------------------------------------------------*/
create            procedure aagTODiv
	@SqlSessionID int
as
	/*This procedure will create distribution for all the existing distribution available in IV.
		v-villaw	date:08-07-2004			Initial implementation*/

begin
	set nocount on

	declare @CMPANYID	smallint,
		@HdrID		int,
		@DOCTYPE	int,
		@DOCNUMBR	char(21)

	select @CMPANYID = CMPANYID from DYNAMICS.dbo.SY01500 where INTERID = DB_NAME()

	select @HdrID = dbo.aagGetNextHdrID(20000) - 1	

	declare  CIV cursor for	
		select	IVDOCTYP,IVDOCNBR
			from IV10001
			group by IVDOCTYP,IVDOCNBR
		union all
		select DOCTYPE,DOCNUMBR
			from IV30300
			group by DOCTYPE,DOCNUMBR
	open CIV
	fetch next from CIV into @DOCTYPE,@DOCNUMBR
	while @@fetch_status	= 0
	begin
		insert into AAG20000
			(aaSubLedgerHdrID,SERIES,DOCTYPE,DOCNUMBR,Master_ID,aaHdrErrors)
			values(dbo.aagGetNextHdrID(20000),5,@DOCTYPE,@DOCNUMBR,' ',0)

		fetch next from CIV into @DOCTYPE,@DOCNUMBR
	end
	close CIV
	deallocate CIV

	update DYNAMICS..AAG00102 set aaRowID = dbo.aagGetNextHdrID(20000) - 1
		where aaTableID = 20000 and CMPANYID = @CMPANYID

	insert into AAG20001
		(aaSubLedgerHdrID, 
		aaSubLedgerDistID, 
		INTERID, ACTINDX, DISTTYPE, aaBrowseType, 
		DEBITAMT, CRDTAMNT, ORDBTAMT, ORCRDAMT, CURNCYID, CURRNIDX, SEQNUMBR,
		GLPOSTDT, aaCustID, POSTED ,RATETPID, EXGTBLID, XCHGRATE,  TIME1,
		RTCLCMTD, DENXRATE, MCTRXSTT)		
		select dbo.aagGetHdrID(5,IVDOCTYP,IVDOCNBR,' ',0,0, getdate(),0,' ',20000),
		DEX_ROW_ID,
		DB_NAME(), IVIVINDX, 0, 0, 
		EXTDCOST, 0, 0, 0, ' ', 0, LNSEQNBR,
		'1999-03-06 00:00:00.000', 0, 1, ' ', ' ', 0,  0, 
		0, 0, 0 from IV10001
		union all
		select dbo.aagGetHdrID(5,IVDOCTYP,IVDOCNBR,' ',0,0, getdate(),0,' ',20000),
		DEX_ROW_ID+ LNSEQNBR+IVIVOFIX+dbo.aagGetHdrID(5,IVDOCTYP,IVDOCNBR,' ',0,0, getdate(),0,' ',20000),
		DB_NAME(), IVIVOFIX, 0, 0, 
		0,EXTDCOST, 0, 0, ' ', 0, LNSEQNBR,
		'1999-03-06 00:00:00.000', 0, 1, ' ', ' ', 0,  0, 
		0, 0, 0 from IV10001
		union all
		select dbo.aagGetHdrID(5,DOCTYPE,DOCNUMBR,' ',0,0, getdate(),0,' ',20000),
		DEX_ROW_ID,
		DB_NAME(), IVIVINDX, 0, 0, 
		EXTDCOST, 0, 0, 0, ' ', 0, LNSEQNBR,
		DOCDATE, 0, 1, ' ', ' ', 0,  0, 
		0, 0, 0 from IV30300 
		union all
		select dbo.aagGetHdrID(5,DOCTYPE,DOCNUMBR,' ',0,0, getdate(),0,' ',20000),
		DEX_ROW_ID+ LNSEQNBR+IVIVOFIX + dbo.aagGetHdrID(5,DOCTYPE,DOCNUMBR,' ',0,0, getdate(),0,' ',20000),
		DB_NAME(), IVIVOFIX, 0, 0, 
		0,EXTDCOST, 0, 0, ' ', 0, LNSEQNBR,
		DOCDATE, 0, 1, ' ', ' ', 0,  0, 
		0, 0, 0 from IV30300 

	insert into AAG20002 
		(aaSubLedgerHdrID,aaSubLedgerDistID,aaSubLedgerAssignID,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,aaAssignedPercent,DistRef,NOTEINDX,aaAssignErrors)
		select aaSubLedgerHdrID,aaSubLedgerDistID,1,DEBITAMT,
		CRDTAMNT,ORDBTAMT,ORCRDAMT,10000,' ',0,0 from AAG20001 where aaSubLedgerHdrID in
		(select aaSubLedgerHdrID from AAG20000 where SERIES = 5)

	set nocount off
end
GO

