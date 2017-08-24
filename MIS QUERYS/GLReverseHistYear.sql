 create procedure GLReverseHistYear  
          @YearToOpen INT,  
          @O_iErrorState INT = NULL 
          OUTPUT  
as 
BEGIN  
    declare @sql1 NVARCHAR(4000),  
    @sql2 NVARCHAR(4000),  
    @sql3 NVARCHAR(4000),  
    @ColumnName VARCHAR(100),  
    @l_cBBF     VARCHAR(255),  
     @l_cPANDL   VARCHAR(255),   
     @l_cINTERID CHAR(5),  
     @l_nStatus  INT,   
     @l_nError   INT   
     declare @sql4 table (aaGLHdrID int)   
     set @l_cINTERID = DB_NAME()   
  exec    @l_nStatus = DYNAMICS.dbo.smGetMsgString 12030, 
          @l_cINTERID, 
          @l_cBBF output, 
          @O_iErrorState output   
          select @l_nError = @@error   
                   if @l_nStatus = 0 and @l_nError <> 0   
                   select @l_nStatus = @l_nError   
                   if ( (@l_nStatus <> 0) or (@O_iErrorState <> 0) )   
                   return (@l_nStatus)    
  exec    @l_nStatus = DYNAMICS.dbo.smGetMsgString 12125, 
          @l_cINTERID, 
          @l_cPANDL output, 
          @O_iErrorState output   
          select @l_nError = @@error   
                  if @l_nStatus = 0 and @l_nError <> 0   
                  select @l_nStatus = @l_nError   
                  if ( (@l_nStatus <> 0) or (@O_iErrorState <> 0) )   
                  return (@l_nStatus)    
                  set @O_iErrorState = 0   
                  if (select count(*) from syscolumns c inner join sysobjects o on c.id = o.id   
                  where o.type = 'U' and o.name = 'GL20000')  <>  (select count(*) from syscolumns c inner join sysobjects o on c.id = o.id   
                  where o.type = 'U' and o.name = 'GL30000')  
                   begin  
                   set @O_iErrorState = 21125  
                   return @O_iErrorState  end   
                   declare T_cursor cursor for   select c.name from syscolumns c inner join sysobjects o on o.id = c.id   
                   where o.name = 'GL20000' and c.name not in ('OPENYEAR', 'DEX_ROW_ID') order by c.name   
                   set @sql1 = ''   
                   open T_cursor  
                   fetch next from T_cursor into @ColumnName   
                     while (@@fetch_status <> -1)  
                      begin  
                       set @sql1 = @sql1+','+rtrim(@ColumnName)  
                       fetch next from T_cursor into @ColumnName   
                      end   
                      close T_cursor  deallocate T_cursor   
                      declare T_cursor cursor for   
  select c.name from syscolumns c inner join sysobjects o on o.id = c.id   
  where o.name = 'GL30000' and c.name not in ('HSTYEAR', 'DEX_ROW_ID') order by c.name   
             set @sql2 = ''   
             open T_cursor  
             fetch next from T_cursor into @ColumnName   while (@@fetch_status <> -1)  
              begin  
              set @sql2 = @sql2+','+rtrim(@ColumnName)  
              fetch next from T_cursor into @ColumnName   
              end   
              close T_cursor  deallocate T_cursor   
              if @sql1 <> @sql2  begin  set @O_iErrorState = 21125  return @O_iErrorState  end   
               set @sql3 = 'insert into GL20000 (OPENYEAR'+@sql1+') select HSTYEAR'+@sql2+' from GL30000   where HSTYEAR = '+cast(@YearToOpen as varchar(4))   
               exec sp_executesql @sql3  if @@Error <> 0  
               begin  
                 set @O_iErrorState = 21126  
                  return @O_iErrorState  end   
                  delete GL30000 where HSTYEAR = @YearToOpen   
                  delete GL10111 where YEAR1 = @YearToOpen  
                  delete MC30001 where HSTYEAR = @YearToOpen  
                  delete GL10110 where YEAR1 = (@YearToOpen+1) and PERIODID = 0  
                  delete MC00201 where OPENYEAR = (@YearToOpen+1) and PERIODID = 0   
                  delete GL20000 where OPENYEAR = (@YearToOpen+1) and SOURCDOC in (@l_cBBF, @l_cPANDL)   
                  if (select count(*) from syscolumns c inner join sysobjects o on c.id = o.id   
                  where o.type = 'U' and o.name = 'GL20001')  <>  (select count(*) from syscolumns c inner join sysobjects o on c.id = o.id   
                  where o.type = 'U' and o.name = 'GL30001')  
                  begin  set @O_iErrorState = 21127  return @O_iErrorState  end   declare T_cursor cursor for   
                  select c.name from syscolumns c inner join sysobjects o on o.id = c.id   
                  where o.name = 'GL20001' and c.name not in ('OPENYEAR', 'DEX_ROW_ID') order by c.name   
                  set @sql1 = ''   
                  
                  open T_cursor  
                  fetch next from T_cursor into @ColumnName   
                   while (@@fetch_status <> -1)  
                   begin  set @sql1 = @sql1+','+rtrim(@ColumnName)  
                   fetch next from T_cursor into @ColumnName   end   
                   
                   close T_cursor  deallocate T_cursor   
                   declare T_cursor cursor for   
                   select c.name from syscolumns c inner join sysobjects o on o.id = c.id  
                    where o.name = 'GL30001' and c.name not in ('HSTYEAR', 'DEX_ROW_ID') order by c.name   
                    set @sql2 = ''   
                    open T_cursor  fetch next from T_cursor into @ColumnName   
                    while (@@fetch_status <> -1)  begin  set @sql2 = @sql2+','+rtrim(@ColumnName)  
                    fetch next from T_cursor into @ColumnName   end   close T_cursor  deallocate T_cursor   if @sql1 <> @sql2  
                    begin  set @O_iErrorState = 21127  return @O_iErrorState  end   
                    set @sql3 = 'insert into GL20001 (OPENYEAR'+@sql1+') select HSTYEAR'+@sql2+' from GL30001   where HSTYEAR = '+cast(@YearToOpen as varchar(4))   
                    exec sp_executesql @sql3  if @@Error <> 0  begin  set @O_iErrorState = 21128  return @O_iErrorState  end   
                    delete GL30001 where HSTYEAR = @YearToOpen   
                    delete GL20001 where OPENYEAR = (@YearToOpen+1) and SOURCDOC in (@l_cBBF, @l_cPANDL)   
                    if exists (select * from dbo.sysobjects where name = 'AAG40000')  
                    begin   insert into @sql4   
                    select a.aaGLHdrID   from AAG30000 a join AAG30001 b on a.aaGLHdrID = b.aaGLHdrID   
                    WHERE a.YEAR1 = (@YearToOpen + 1) and b.SOURCDOC in (@l_cBBF, @l_cPANDL)  group by a.aaGLHdrID  order by a.aaGLHdrID   
                    INSERT INTO AAG30000 SELECT aaGLHdrID, JRNENTRY, RCTRXSEQ, YEAR1,   aaTRXType, aaGLTRXSource, aaTRXSource, GLPOSTDT, Ledger_ID   
                    FROM AAG40000 WHERE YEAR1 = @YearToOpen   
                    INSERT INTO AAG30001 (aaGLHdrID,aaGLDistID, INTERID, CorrespondingUnit,   ACTINDX, ACCTTYPE, aaBrowseType, DECPLACS, DEBITAMT, CRDTAMNT,   ORDBTAMT,ORCRDAMT,CURNCYID,CURRNIDX, RATETPID,EXGTBLID,  XCHGRATE,EXCHDATE,TIME1,RTCLCMTD, DENXRATE,MCTRXSTT, SEQNUMBR,  aaCustID,aaVendID,aaSiteID,aaItemID,EMPLOYID, aaCopyStatus, SOURCDOC, aaChangeDate,aaChangeTime)   
                    SELECT aaGLHdrID,aaGLDistID, INTERID, CorrespondingUnit,   ACTINDX, ACCTTYPE, aaBrowseType, DECPLACS, DEBITAMT, CRDTAMNT,   ORDBTAMT,ORCRDAMT,CURNCYID,CURRNIDX, RATETPID,EXGTBLID,  XCHGRATE,EXCHDATE,TIME1,RTCLCMTD, DENXRATE,MCTRXSTT, SEQNUMBR,  aaCustID,aaVendID,aaSiteID,aaItemID,EMPLOYID, aaCopyStatus, SOURCDOC, aaChangeDate,aaChangeTime   
                    FROM AAG40001 WHERE exists(
                                  SELECT 1 FROM AAG40000   
                                  WHERE AAG40000.aaGLHdrID = AAG40001.aaGLHdrID and YEAR1 = @YearToOpen)   
                                  INSERT INTO AAG30002 (aaGLHdrID,aaGLDistID,aaGLAssignID, DEBITAMT,CRDTAMNT,  ORDBTAMT,ORCRDAMT,aaAssignedPercent, DistRef,NOTEINDX)  
                                  SELECT aaGLHdrID,aaGLDistID,aaGLAssignID, DEBITAMT,CRDTAMNT,  ORDBTAMT,ORCRDAMT,aaAssignedPercent, DistRef,NOTEINDX  
                                  FROM AAG40002 WHERE exists(SELECT 1 FROM AAG40000   WHERE AAG40000.aaGLHdrID = AAG40002.aaGLHdrID and YEAR1 = @YearToOpen)   
                                  INSERT INTO AAG30003 (aaGLHdrID, aaGLDistID, aaGLAssignID, aaTrxDimID, aaTrxCodeID)   
                                  SELECT aaGLHdrID, aaGLDistID, aaGLAssignID, aaTrxDimID, aaTrxCodeID   
                                  FROM AAG40003 WHERE exists(SELECT 1 FROM AAG40000   WHERE AAG40000.aaGLHdrID = AAG40003.aaGLHdrID and YEAR1 = @YearToOpen)   
                                  DELETE AAG40001 WHERE exists(SELECT 1 FROM AAG40000   WHERE AAG40000.aaGLHdrID = AAG40001.aaGLHdrID and YEAR1 = @YearToOpen)   
                                  DELETE AAG40002 WHERE exists(SELECT 1 FROM AAG40000   WHERE AAG40000.aaGLHdrID = AAG40002.aaGLHdrID and YEAR1 = @YearToOpen)   
                                  DELETE AAG40003 WHERE exists(SELECT 1 FROM AAG40000   WHERE AAG40000.aaGLHdrID = AAG40003.aaGLHdrID and YEAR1 = @YearToOpen)   
                                  DELETE AAG40000 WHERE YEAR1 = @YearToOpen   
                                  DELETE AAG30002 WHERE exists(
                                                 SELECT 1 FROM AAG30001   inner join AAG30000 on AAG30001.aaGLHdrID = AAG30000.aaGLHdrID 
                                                WHERE AAG30001.aaGLHdrID = AAG30002.aaGLHdrID  and YEAR1 = (@YearToOpen + 1) and SOURCDOC in (@l_cBBF, @l_cPANDL))   
                                 DELETE AAG30003 WHERE exists(SELECT 1 FROM AAG30001  inner join AAG30000 on AAG30001.aaGLHdrID = AAG30000.aaGLHdrID WHERE AAG30001.aaGLHdrID = AAG30003.aaGLHdrID and YEAR1 = (@YearToOpen + 1) and SOURCDOC in (@l_cBBF, @l_cPANDL))   
                                 DELETE AAG30001 WHERE exists(SELECT 1 FROM AAG30000  WHERE AAG30000.aaGLHdrID = AAG30001.aaGLHdrID and YEAR1 = (@YearToOpen + 1) and SOURCDOC in (@l_cBBF, @l_cPANDL))  
                                 DELETE AAG30000 WHERE aaGLHdrID in (select aaGLHdrID from @sql4)  end   
                                 
                                 UPDATE SY40101 set HISTORYR = 0 WHERE YEAR1 = @YearToOpen  if exists (select * from SY40101 WHERE YEAR1 = (@YearToOpen-1))  
                                 begin  UPDATE GL40000 set LSTCLSDT = (SELECT LSTFSCDY FROM SY40101 WHERE YEAR1 = (@YearToOpen-1))   end 
 END   