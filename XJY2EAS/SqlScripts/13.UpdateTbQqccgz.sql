declare @ProjectID nvarchar(50),  
 @AccountCode varchar(100)=null  
  
if not exists(select 1 from dbo.tbvoucher )  
 return;  
  IF OBJECT_ID('tempdb..#accounting') IS NOT  NULL  
 DROP TABLE #accounting 
select * into #accounting from dbo.Account where 1!=1  
  
if (len(isnull(@AccountCode,''))>0)begin  
 insert #accounting select * from dbo.Account  with(nolock) where projectid=@ProjectID and accountcode=@AccountCode  
end else begin  
 insert #accounting select * from dbo.Account  with(nolock)     
end  
  
alter table #accounting add ID int IDENTITY(1,1)   

 
  
--本年度所有凭证数据  
 IF OBJECT_ID('tempdb..#voucher') IS NOT  NULL  
 DROP TABLE #voucher 

create table #voucher(accountcode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,  
 FDetailID int,fllx int,jfje decimal(20,2),dfje decimal(20,2),syjz int)  
  

insert #voucher  
select v.accountcode,v.FDetailID,v.fllx,v.jfje,v.dfje,a.syjz from dbo.tbvoucher v   with(nolock)  
 inner join #accounting a  
 on v.accountcode=a.accountcode   
  
--todo:调用更新jfje,dfje  

 IF OBJECT_ID('tempdb..#tbvouchersum') IS NOT  NULL  
 DROP TABLE #tbvouchersum 
create table #tbvouchersum (ID int IDENTITY(1,1),AccountCode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,  
   AuxiliaryCode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,Qqccgz decimal(20,2))  
  
insert #tbvouchersum (AccountCode,Qqccgz)  
select distinct vo.AccountCode,(sum(vo.jfje)-sum(vo.dfje))Qqccgz  
 from #voucher vo   
 where vo.fllx=3  
 group by vo.AccountCode  

 
  IF OBJECT_ID('tempdb..#a2') IS NOT  NULL  
 DROP TABLE #a2 

create table #a2(ID int IDENTITY(1,1),accountcode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,  
 AuxiliaryCode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,Qqccgz decimal(20,2))  
insert #a2(accountcode,Qqccgz)  
select accountcode,sum(Qqccgz)Qqccgz from #tbvouchersum group by accountcode  
  
update b set b.Qqccgz=0  
 from TBDetail   b   
 join #accounting a  
 on b.accountcode=a.accountcode  
 where b.isaux=0 and b.auxiliarycode='' and b.datatype=0  
  
update acc set acc.Qqccgz=tv.Qqccgz  
from dbo.TBDetail acc with(nolock)   
join #a2 tv  
on acc.accountcode=tv.AccountCode and acc.isaux=0  
where  exists(select 1 from #accounting where AccountCode=acc.AccountCode)  
   
 
  
TRUNCATE TABLE  #tbvouchersum  
  
--update tbaux jfje,dfje  
insert #tbvouchersum (AccountCode,AuxiliaryCode,Qqccgz)  
select distinct af.AccountCode,af.AuxiliaryCode,(sum(vo.jfje)-sum(vo.dfje)) as Qqccgz  
 from dbo.AuxiliaryFDetail af with(nolock)   
  inner join #voucher vo   
  on vo.AccountCode=af.accountcode AND vo.FDetailID=af.FDetailID AND af.DATATYPE=0  
  where vo.fllx=3  
  group by af.AccountCode,af.AuxiliaryCode 

  
insert #a2  
select accountcode,AuxiliaryCode,sum(Qqccgz)Qqccgz from #tbvouchersum group by accountcode,AuxiliaryCode  
  
update t set t.Qqccgz=a.Qqccgz  
from dbo.TBDetail t with(nolock)   
inner join #a2 a  
on t.accountcode=a.accountcode and t.AuxiliaryCode=a.AuxiliaryCode  
where  exists(select 1 from #accounting where AccountCode=t.AccountCode)  
  
drop table #tbvouchersum  
drop table #voucher  
drop table #a2  
  
