declare 
 @ProjectID varchar(100)  ='_EAS_'
 ,@Clientid varchar(100)  ='_Clientid_'
    
truncate table ProjectType
truncate table Project   
truncate table Account   
truncate table TBVOUCHER


 insert ProjectType(ProjectID,typecode,typename)  
 select distinct @ProjectID,typecode,typename from  EAS_PROJECTTYPE  
  
 insert Project(ProjectID,typecode,projectcode,projectname,uppercode,jb,ismx)  
 select distinct @ProjectID,typecode,projectcode,isnull(projectname,space(0)),uppercode,jb,ismx from EAS_PROJECT


 IF exists (select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..#tmp222') and type='U')   
   drop table #tmp222

 select DISTINCT a.accountcode,ac.syjz  
  into #tmp222  
   from EAS_ACCOUNT a   
   inner join Accountclass ac with(nolock)  
   on a.Accountname like ac.AccountName+'%'  
   where a.jb=1   
   
 insert #tmp222  
 select DISTINCT a.accountcode,b.syjz  
   from EAS_ACCOUNT a   
   inner join #tmp222 b   
   on left(a.accountcode,len(b.accountcode))=b.accountcode  
   where a.jb>1  
  
  
 insert Account(ProjectID,[AccountCode],[AccountName],[jd],[hsxms],[TypeCode],[IsMx],[Ncye],[Jfje],[Dfje],[Ncsl],jb,syjz)  
 select distinct @ProjectID,a.[AccountCode],[AccountName],[jd],[hsxms],[TypeCode],[IsMx],  
           sum([Ncye]),sum([Jfje]),sum([Dfje]),sum([Ncsl]),jb,case when t.syjz is null   then 1 else t.syjz end syjz  
  from EAS_ACCOUNT a  
  left join #tmp222 t  
  on a.AccountCode=t.accountcode   
   group by a.[AccountCode],[AccountName],[jd],[hsxms],[TypeCode],[IsMx],JB,t.syjz
   
    
   IF exists (select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..#p1') and type='U')   
   drop table #p1
 select @Clientid as Clientid,@ProjectID as ProjectID,IncNo,Date, year(Date)*100+month(Date) as Period,Pzlx,Pzh,Djh,AccountCode,ProjectCode,Zy,Jfje,Dfje,Jfsl,Dfsl,  
   zdr,dfkm,FDetailID,0 as fsje,0 as Hl,0 as jd  
  into #p1  
  from EAS_Voucher 
  
 alter table #p1 add ID int IDENTITY(1,1)  
  
 declare @leve int=10000  
 declare @ix int=1  
 declare @ixend int=@leve   
 while (1=1)begin  
  insert dbo.TBVOUCHER(Clientid,ProjectID,IncNo,Date,Period,Pzlx,Pzh,Djh,AccountCode,ProjectCode,Zy,Jfje,Dfje,Jfsl,Dfsl,zdr,dfkm,FDetailID,fsje,Hl,jd)  
  select Clientid,ProjectID,IncNo,Date,Period,Pzlx,Pzh,Djh,AccountCode,ProjectCode,Zy,Jfje,Dfje,Jfsl,Dfsl,zdr,dfkm,FDetailID,  
    case when jfje<>0 then 1 else -1 end *(Jfje+Dfje) as fsje,Hl,  
    case when jfje<>0 then 1 else -1 end as jd  
    from #p1   where ID BETWEEN @ix and @ixend  
    
  if @@ROWCOUNT=0  
   break;  
  set @ix+=@leve   
  set @ixend+=@leve   
 end  
  
  
   
 update dbo.tbwlzl  set AgeAnalysis=0,BalanceAnalysis=0  
   
 --¸üÐÂaccount.uppercode  
 exec dbo.UpdateAccountUpperCodeLevel1 @ProjectID  
   
 exec dbo.UpdateAccountPeriod @ProjectID,0  
  
