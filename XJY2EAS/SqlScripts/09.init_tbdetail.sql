declare  @ProjectID nvarchar(50)   ='_EAS_' 

truncate table tbdetail 

IF OBJECT_ID('tempdb..#Account') IS NOT  NULL  
 DROP TABLE #Account 
  
 select distinct NEWID() IID ,@ProjectID AS projectid,a.AccountCode,space(0) AS AuxiliaryCode,space(0) AS SourceFSCode,  
 a.AccountName as AccAuxName,a.jb as TBType,0 AS IsMx,a.UpperCode  TBGrouping,a.Ncye AS Sqqmye,  
space(0) fscode,1 yefx,0 kmsx,0 AS isAux,a.ismx AS isAccMx,0 AS DataType  
into #Account  
from dbo.Account a with(nolock)   
  
alter table #Account add ID int IDENTITY(1,1)  

declare @leve int=1000  
declare @ix int=1  
declare @ixend int=@leve   
  
while (1=1)begin  
  insert into dbo.TBDetail (ID,projectid,AccountCode,AuxiliaryCode,SourceFSCode,AccAuxName,TBType,IsMx,TBGrouping,Sqqmye,  
  fscode,yefx,kmsx,isAux,isAccMx,DataType)  
  
  select IID,projectid,AccountCode,AuxiliaryCode,SourceFSCode,AccAuxName,TBType,IsMx,isnull(TBGrouping,SPACE(0)) TBGrouping,Sqqmye,  
   fscode,yefx,kmsx,isAux,isAccMx,DataType  
    from #Account
	     where id BETWEEN @ix and @ixend  
   
 if @@ROWCOUNT=0  
  break;  
 set @ix+=@leve   
 set @ixend+=@leve   
end  
  
--todo:update ext  
--exec dbo.ByContinueDateUpdateTBAcc @ProjectID  
   