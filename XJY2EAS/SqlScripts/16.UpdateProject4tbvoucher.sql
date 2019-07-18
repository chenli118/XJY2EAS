declare @ProjectID nvarchar(50)  ='_EAS_'     
 ,@DateType int =0
SET NOCOUNT ON      
declare @leve int=1000      
declare @ix int=1      
declare @ixend int=@leve       
      
if OBJECT_ID('tempdb..#p1') IS NOT NULL    
 drop table #p1    
    
select ROW_NUMBER() OVER (ORDER BY t.accountcode) AS ID,  t.fscode,    
 t.projectid, t.accountcode,t.auxiliaryCode,a.DataYear,a.FDetailID      
 into #p1   
 from dbo.TBDetail t  
 inner join dbo.AuxiliaryFDetail a      
 on  t.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=a.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS      
  and t.auxiliarycode COLLATE Chinese_PRC_CS_AS_KS_WS=a.auxiliarycode COLLATE Chinese_PRC_CS_AS_KS_WS      
  and a.datatype=@DateType      
 where   t.datatype=0 and t.auxiliarycode!=''      
      
    

if(@DateType=0)begin      
      
update v  set v.ProjectCode=a1.auxiliaryCode
from dbo.TBVoucher v 
inner join #p1 a1 on v.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=a1.accountcode 
COLLATE Chinese_PRC_CS_AS_KS_WS  and v.FDetailID=a1.FDetailID    
      
 
end      
else  if(@DateType=-1)begin --前期凭证      
 update v       
  set v.ProjectCode=a1.auxiliaryCode      
  from dbo.Qcwljzpz v      
  inner join #p1 a1      
  on v.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=a1.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS      
   and v.FDetailID=a1.FDetailID        
     and a1.datayear=year(v.date)       
    
end       
else  if(@DateType=1)begin--期后凭证      
       
 update v       
  set v.ProjectCode =a1.auxiliaryCode      
  from dbo.QhJzpz v      
  inner join #p1 a1      
  on v.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=a1.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS      
   and v.FDetailID=a1.FDetailID          
     and a1.datayear=year(v.date)        
end      
 