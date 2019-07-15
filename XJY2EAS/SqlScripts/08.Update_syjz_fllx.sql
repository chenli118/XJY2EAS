declare @ProjectID nvarchar(50) ='_EAS_',  
 @tableType int=0 --0 tbvoucher 本期凭证;1 qhjzpz 期后凭证  
  
SET NOCOUNT ON  
declare @incno varchar(100),@maxsyjz int,@minsyjz int;  
declare @ix int=1  
declare @leve int=1000  
declare @ixend int=@leve    
IF OBJECT_ID('tempdb..#VandA') IS NOT  NULL  
 DROP TABLE #VandA 
if(@tableType=0)begin  
 with a1 as(  
 select distinct t.incno,a.syjz from dbo.tbvoucher t with(nolock)  
 join dbo.Account a with(nolock)  
 on t.AccountCode=a.AccountCode and t.Projectid=a.Projectid    
 )  
 ,a2 as (select incno,max(syjz)maxsyjz,min(syjz)minSyjz from a1 group by incno)  
 select ROW_NUMBER() OVER (ORDER BY NEWID()) AS ID, * into #VandA from a2;  
   
 update v set v.fllx=case   
      when a.maxsyjz=3 then 3   
      when a.maxsyjz=2 and a.minSyjz=1 then 2  
      else 1 end  
   from dbo.tbvoucher v  
   inner join #VandA a  
   on v.incno=a.incno   

end 

else if(@tableType=1)
begin
   IF OBJECT_ID('tempdb..#QHV') IS NOT  NULL  
 DROP TABLE #QHV
 update dbo.qhjzpz set fllx=1 where ProjectID=@ProjectID;  
 ;  
 with a1 as(  
 select distinct t.incno,a.syjz from dbo.qhjzpz t with(nolock)  
 join dbo.Account a with(nolock)  
 on t.AccountCode=a.AccountCode and t.Projectid=a.Projectid   
 )  
 ,a2 as (select incno,max(syjz)maxsyjz,min(syjz)minSyjz from a1 group by incno)  
 select ROW_NUMBER() OVER (ORDER BY NEWID()) AS ID, * into #QHV from a2;  
   
 update v set v.fllx=case   
      when a.maxsyjz=3 then 3   
      when a.maxsyjz=2 and a.minSyjz=1 then 2  
      else 1 end  
   from dbo.qhjzpz v  
   inner join #QHV a  
   on v.incno=a.incno   
  
end  
  
