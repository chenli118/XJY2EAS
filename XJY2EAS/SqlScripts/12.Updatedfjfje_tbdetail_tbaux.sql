declare  @ProjectID nvarchar(50),  
 @AccountCode varchar(100)=null  
 
  
if not exists(select 1 from dbo.tbvoucher)  
 return;  
  
  IF OBJECT_ID('tempdb..#accounting') IS NOT  NULL  
   DROP TABLE #accounting 

select * into #accounting from dbo.Account where 1!=1  
  
 
  
if (len(isnull(@AccountCode,''))>0)begin  
 insert #accounting select * from dbo.Account with(nolock)  where  accountcode=@AccountCode  
end else begin  
 insert #accounting select * from dbo.Account with(nolock)  
end  
  
alter table #accounting add ID int IDENTITY(1,1)  

  IF OBJECT_ID('tempdb..#voucher') IS NOT  NULL  
   DROP TABLE #voucher 
create table #voucher(accountcode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,  
 FDetailID int,fllx int,jfje decimal(20,2),dfje decimal(20,2),syjz int)  
  
 
insert #voucher  
select  v.accountcode,v.FDetailID,v.fllx,v.jfje,v.dfje,a.syjz 
from dbo.tbvoucher v  with(nolock)  
 inner join #accounting a  
 on v.accountcode=a.accountcode  
 
--添加索引  
--create index ix_apcode_voucher on #voucher (accountcode)  
  
  IF OBJECT_ID('tempdb..#tbvouchersum') IS NOT  NULL  
   DROP TABLE #tbvouchersum 
create table #tbvouchersum (ID int IDENTITY(1,1),AccountCode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,  
 FDetailID int,jfje decimal(20,2),dfje decimal(20,2))  

   IF OBJECT_ID('tempdb..#account1') IS NOT  NULL  
   DROP TABLE #account1 
create table #account1 (projectid varchar(100),AccountCode varchar(100) collate Chinese_PRC_CS_AS_KS_WS)  
  
;with a1 as (  
select projectid,accountcode from account with(nolock)  where accountname='以前年度损益调整' 
UNION ALL  
select  a.projectid,a.accountcode from account a with(nolock)   
inner join a1   
on a.uppercode=a1.accountcode  
and a.accountcode!=a.accountcode  )  
insert #account1  
SELECT * FROM a1  
  
insert #tbvouchersum (AccountCode,jfje,dfje)  
select distinct AccountCode ,sum(jfje)jfje,sum(dfje)dfje  
 from #voucher where fllx=1 and syjz=1  
 AND ACCOUNTCODE NOT in (select accountcode from #account1)  
 group by AccountCode  
union all  
select distinct AccountCode ,sum(jfje)jfje,sum(dfje)dfje  
 from #voucher   
  where  (fllx=1 or fllx=2)   
   and (syjz!=1 or ACCOUNTCODE in(select accountcode from #account1))  
   group by AccountCode  
  
declare @leve int=1000  
declare @ix int=1  
declare @ixend int=@leve   
  
update b set b.jfje=0,b.dfje=0   
 from TBDetail   b   
 join #accounting a  
 on b.accountcode=a.accountcode  
 where  b.isaux=0 and b.auxiliarycode='' and b.datatype=0  
  
update acc set acc.jfje=tv.jfje,acc.dfje=tv.dfje  
from dbo.TBDetail acc with(nolock)   
join #tbvouchersum tv  
on acc.accountcode=tv.AccountCode and acc.isaux=0 and acc.auxiliarycode='' and acc.datatype=0   
  
TRUNCATE TABLE #tbvouchersum  
--update tbaux jfje,dfje  
  
insert #tbvouchersum (AccountCode,FDetailID,jfje,dfje)  
select distinct vo.AccountCode,vo.FDetailID,sum(vo.jfje)jfje,sum(vo.dfje)dfje  
 from #voucher vo where vo.fllx=1 and vo.syjz=1  
  AND ACCOUNTCODE NOT in (select accountcode from #account1)  
 group by vo.AccountCode,vo.FDetailID  
union all  
select distinct vo.AccountCode,vo.FDetailID,sum(vo.jfje)jfje,sum(vo.dfje)dfje  
 from #voucher vo  
 WHERE (vo.FLLX=1 OR vo.FLLX=2)  
   and (syjz!=1 or ACCOUNTCODE in(select accountcode from #account1))  
 group by vo.AccountCode,vo.FDetailID  
  
    IF OBJECT_ID('tempdb..#p0') IS NOT  NULL  
   DROP TABLE #p0
select af.accountcode,af.AuxiliaryCode,sum(v.jfje)jfje,sum(v.dfje)dfje  
 into #p0  
 from dbo.AuxiliaryFDetail af with(nolock)   
  inner join #tbvouchersum v  
  on V.AccountCode=AF.accountcode AND AF.FDetailID=V.FDetailID   
  group by af.accountcode,af.AuxiliaryCode  
  

    IF OBJECT_ID('tempdb..#p1') IS NOT  NULL  
   DROP TABLE #p1


select ROW_NUMBER() OVER (ORDER BY accountcode) AS ID, accountcode,AuxiliaryCode,jfje,dfje   
 into #p1  
 from #p0  
  
drop table #p0  
  
--更新tbaux jfje,dfje  
update  aux set aux.jfje=0,aux.dfje=0  
from dbo.TbAux aux  
inner join #p1 AV  
on av.AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS=aux.AccountCode  COLLATE Chinese_PRC_CS_AS_KS_WS   
  
update  aux set aux.jfje=isnull(av.jfje,0),aux.dfje=isnull(av.dfje,0)  
from dbo.TbAux aux with(nolock)   
inner join #p1 AV  
on av.AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS=aux.AccountCode  COLLATE Chinese_PRC_CS_AS_KS_WS  
 and av.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS=aux.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS   
  
drop table #p1  
  
--update jfje1,dfjfe1   
Update ac1 set ac1.jfje1=ac2.jfje,ac1.dfje1=ac2.dfje  
From dbo.TBDetail ac1 with(nolock)   
Inner join TBDetail ac2  with(nolock)   
 on ac1.accountcode=ac2.accountcode  and ac2.isaux=0  
Where   ac1.isaux=0  
  
Update dbo.TBDetail set jfje2=jfje-jfje1,dfje2=dfje-dfje1   
where  isaux=0  
  
drop table #voucher  
drop table #accounting  
  
--只要修改了科目属性、凭证类型、和凭证金额都需要执行以下这个过程  
update  ad set ad.jfje=isnull(av.jfje,0),ad.dfje=isnull(av.dfje,0)  
from dbo.tbdetail ad with(nolock)   
inner join dbo.TbAux av with(nolock)   
on av.AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS=ad.AccountCode  COLLATE Chinese_PRC_CS_AS_KS_WS  
 and av.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS=ad.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS  
   
 