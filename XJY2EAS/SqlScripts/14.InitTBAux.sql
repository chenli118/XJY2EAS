declare  @ProjectID nvarchar(50)='_EAS_'
 ,@accountCode varchar(100)=null   
  
IF OBJECT_ID('tempdb..#voucher') IS NOT  NULL  
 DROP TABLE #voucher 

create table #voucher(accountcode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,  
 FDetailID int,fllx int,jfje decimal(20,2),dfje decimal(20,2),syjz int)  
  
IF OBJECT_ID('tempdb..#tbvouchersum') IS NOT  NULL  
 DROP TABLE #tbvouchersum 

create table #tbvouchersum (AccountCode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,  
 FDetailID int,jfje decimal(20,2),dfje decimal(20,2))  
  
IF OBJECT_ID('tempdb..#accounting') IS NOT  NULL  
 DROP TABLE #accounting 

create table #accounting(AccountCode varchar(100) collate Chinese_PRC_CS_AS_KS_WS,syjz int )  
  
if(dbo.ISNullEmpty(@accountCode,'')!='')  
insert #accounting  
select accountcode,syjz from dbo.Account  with(nolock) where (projectid=@ProjectID and accountcode like @accountCode+'%')  
else   
insert #accounting  
select accountcode,syjz from dbo.Account  with(nolock) 
  
declare @year int,@currentyearpid varchar(100),@PeriodEndDate datetime,@clientid varchar(100)  
select @year=year(PeriodEndDate),@PeriodEndDate=PeriodEndDate,  
 @currentyearpid=currentyearpid,@clientid=clientid  
   from neweasv5.dbo.projectsinfo  with(nolock) where projectid=@ProjectID  
  
insert #voucher  
select v.accountcode,v.FDetailID ,v.fllx,v.jfje,v.dfje,a.syjz from dbo.tbvoucher v  with(nolock)   
 inner join #accounting a  
 on v.accountcode=a.accountcode   
  
--Ìí¼ÓË÷Òý 

   
create index ix_apcode_voucher on #voucher (accountcode,FDetailID)  
  
insert #tbvouchersum  
select distinct vo.AccountCode,vo.FDetailID,sum(vo.jfje)jfje,sum(vo.dfje)dfje  
 from #voucher vo where vo.fllx=1 and vo.syjz=1  
 group by vo.AccountCode,vo.FDetailID  
union all  
select distinct vo.AccountCode,vo.FDetailID,sum(vo.jfje)jfje,sum(vo.dfje)dfje  
 from #voucher  vo  
 WHERE (vo.FLLX=1 OR vo.FLLX=2)  
   and (vo.syjz!=1 or ACCOUNTCODE COLLATE Chinese_PRC_CS_AS_KS_WS in(select accountcode from dbo.Account with(nolock) ))  
 group by vo.AccountCode,vo.FDetailID  
  

  IF OBJECT_ID('tempdb.. #p0') IS NOT  NULL  
   DROP TABLE  #p0 

select af.accountcode,af.AuxiliaryCode,sum(v.jfje)jfje,sum(v.dfje)dfje  
 into #p0   
 from dbo.AuxiliaryFDetail af with(nolock)   
  inner join #tbvouchersum v  
  on V.AccountCode=AF.accountcode AND AF.FDetailID=V.FDetailID AND AF.DATATYPE=0   
  group by af.accountcode,af.AuxiliaryCode  
  
 IF OBJECT_ID('tempdb.. #p1') IS NOT  NULL  
   DROP TABLE  #p1
select ROW_NUMBER() OVER (ORDER BY accountcode) AS ID, accountcode,AuxiliaryCode,jfje,dfje into #p1 from #p0  
   IF OBJECT_ID('tempdb.. #p2') IS NOT  NULL  
   DROP TABLE  #p2
select ROW_NUMBER() OVER (ORDER BY accountcode) AS ID,accountcode,fscode,kmsx,yefx  
       into #p2  
       from dbo.TbDetail with(nolock)   
         where auxiliarycode='' and datatype=0 and isaux=0 and projectid=@ProjectID  
  
;MERGE DBO.TBAux AS AUX  
USING  #p1 AS DET  
ON AUX.ACCOUNTCODE COLLATE Chinese_PRC_CS_AS_KS_WS=DET.ACCOUNTCODE COLLATE Chinese_PRC_CS_AS_KS_WS  
 AND aux.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS=det.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS  
WHEN MATCHED  
THEN UPDATE SET aux.jfje=isnull(det.jfje,0),aux.dfje=isnull(det.dfje,0);  
  
MERGE DBO.TBAux AS AUX  
USING  #p2 AS DET  
ON AUX.ACCOUNTCODE COLLATE Chinese_PRC_CS_AS_KS_WS=DET.ACCOUNTCODE COLLATE Chinese_PRC_CS_AS_KS_WS  
WHEN MATCHED  
THEN UPDATE SET aux.fscode=det.fscode,aux.KMSX=det.kmsx,aux.yefx=det.yefx;  
  
DROP TABLE #accounting  
DROP TABLE #p2  
DROP TABLE #p1  
DROP TABLE #p0  
DROP TABLE #voucher  
DROP TABLE #tbvouchersum  
  
