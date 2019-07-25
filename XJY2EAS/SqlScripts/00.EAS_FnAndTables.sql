

if exists (select 1
            from  sysobjects
           where  id = object_id('kjqj')
            and   type = 'U')
   drop table kjqj

CREATE TABLE kjqj    ( ProjectID VARCHAR(100),CustomerCode VARCHAR(100),CustomerName VARCHAR(100),     BeginDate date,EndDate date, KJDate    VARCHAR(4) NOT NULL    , CONSTRAINT PK_KJQJ PRIMARY KEY(ProjectID, KJDate)    )
go

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ISNullEmpty]') AND xtype IN ( N'FN', N'IF', N'TF' ) ) 
   BEGIN
       DROP FUNCTION [dbo].[ISNullEmpty]
   END
GO
 
CREATE FUNCTION [dbo].[ISNullEmpty]
(
	@param1 varchar(max),
	@param2 varchar(max)
)
RETURNS varchar(1000)
AS
BEGIN
	return	case when len(isnull(@param1,''))=0 then @param2	else @param1	end;
END

GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[IndexSplterNumber]') AND xtype IN ( N'FN', N'IF', N'TF' ) ) 
   BEGIN
       DROP FUNCTION [dbo].[IndexSplterNumber]
   END
GO

CREATE FUNCTION IndexSplterNumber
(
	@SourceSql varchar(8000),@StrSeprate varchar(10)
)
RETURNS int
AS
begin
declare @i int,@ii int=0

if(@SourceSql is not null)
	set	@ii+=1

set @SourceSql=rtrim(ltrim(@SourceSql))
set @i=charindex(@StrSeprate,@SourceSql)

while @i>=1
begin
	set @SourceSql=substring(@SourceSql,@i+1,len(@SourceSql)-@i)
	set @i=charindex(@StrSeprate,@SourceSql)
	set	@ii+=1	
end
	return	@ii--case when @ii>0 then @ii+1 else @ii end
end

GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_SplitTSQL]') AND xtype IN ( N'FN', N'IF', N'TF' ) ) 
   BEGIN
       DROP FUNCTION [dbo].[fn_SplitTSQL]
   END
GO
 
CREATE FUNCTION dbo.fn_SplitTSQL(@SourceSql varchar(8000),@StrSeprate varchar(10))
	returns @temp table(code varchar(100)	COLLATE Chinese_PRC_CS_AS_KS_WS	NULL)
as 
begin
declare @i int
set @SourceSql=rtrim(ltrim(@SourceSql))
set @i=charindex(@StrSeprate,@SourceSql)
while @i>=1
begin
insert @temp values(left(@SourceSql,@i-1))
set @SourceSql=substring(@SourceSql,@i+1,len(@SourceSql)-@i)
set @i=charindex(@StrSeprate,@SourceSql)
end
if @SourceSql<>''
insert @temp values(@SourceSql)
return 
end


GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE type = 'P' AND name = 'PRO_THROW')
   BEGIN
       DROP  Procedure  PRO_THROW
	END
GO
/********************************************************************************
  Database  : EAS
  Copyright : 2010 Huapu (Beijing)
  Customer  : 
  Project   : EAS -异常处理
  Created   : 2011/05/24 by dengll,rshibin
  Version   : 1.0.8
********************************************************************************/

Create PROCEDURE dbo.PRO_THROW
		@projectid varchar(100),
		@ErrorProcedure1	varchar(100)=''
    AS  
BEGIN  
      
    SET NOCOUNT ON;  
        DECLARE   
        @ErrorMessage    NVARCHAR(4000),  
        @ErrorNumber     INT,  
        @ErrorSeverity   INT,  
        @ErrorState      INT,  
        @ErrorLine       INT,  
        @ErrorProcedure  NVARCHAR(200);  
        SELECT   
        @ErrorNumber = ERROR_NUMBER(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE(),  
        @ErrorLine = ERROR_LINE(), 
        @ErrorProcedure = ISNULL(ISNULL(ERROR_PROCEDURE(), '-'),@ErrorProcedure1);  
        SELECT @ErrorMessage = N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 'Message: '+ ERROR_MESSAGE();  
      
	  EXEC dbo.LogWrongInfo @projectid,@ErrorProcedure

    RAISERROR (  
        @ErrorMessage,   
        @ErrorSeverity,   
        1,                 
        @ErrorNumber,  
        @ErrorSeverity,  
        @ErrorState,  
        @ErrorProcedure,  
        @ErrorLine  
        );  
      
END  


GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE type = 'P' AND name = 'LogWrongInfo')
   BEGIN
       DROP  Procedure  LogWrongInfo
	END
GO

CREATE PROC LogWrongInfo
	@pid	 VARCHAR(1000),

	--@ERROR_NUMBER	int,--返回错误号
	--@ERROR_SEVERITY	int,--返回严重性
	--@ERROR_STATE		int,--返回错误状态号
	@ERROR_PROCEDURE	VARCHAR(255)--返回出现错误的存储过程或 触发器的名称
	--@ERROR_LINE	int,--返回导致错误的例程中的行 号
	--@ERROR_MESSAGE	VARCHAR(1000)	--返回错误消息的完整文本
AS 
BEGIN
if (OBJECT_id('LogTable') is NULL)	
BEGIN	--create table logtable
	CREATE TABLE LogTable
	( 
	  ID              int identity(1,1),--错误序号
	  Projectid	VARCHAR(1000),
	  ErrorDateTime	DATETIME NOT NULL,
	  ErrorNumber     int,--错误号
	  ErrorSeverity   int,--严重性
	  ErrorState      int,--错误状态号
	  ErrorProducure  varchar(255),--出现错误的存储过程或 触发器的名称
	  ErrorLine       int,--导致错误的例程中的行号
	  ErrorMessage    varchar(1000)--错误消息的完整文本
)END

INSERT INTO LogTable values(@pid,GETDATE(),ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),@ERROR_PROCEDURE,ERROR_LINE(),ERROR_MESSAGE())

END
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE type = 'P' AND name = 'UpdateTBDetailTBAuxJE')
   BEGIN
       DROP  Procedure  UpdateTBDetailTBAuxJE
	END
GO
  
Create proc UpdateTBDetailTBAuxJE(@pzEndDate date)
 as
 begin 
;with  t0 as (select projectid,accountcode from account with(nolock)  where accountname='以前年度损益调整'	UNION ALL select  a.projectid,a.accountcode from account a with(nolock) inner join t0 on a.uppercode=t0.accountcode    and a.accountcode!=a.accountcode)
,t1 as(select accountcode,syjz from dbo.Account where Syjz=0)
,t2 as(select v.accountcode,v.FDetailID ,v.fllx,v.jfje,v.dfje,t1.syjz from dbo.tbvoucher v  with(nolock)   join  t1 on t1.accountcode  = v.AccountCode  where v.date<@pzEndDate)
,t3 as(select distinct vo.AccountCode,sum(vo.jfje)jfje,sum(vo.dfje)dfje   from t2 vo where vo.fllx=1 and vo.syjz=1 AND	ACCOUNTCODE NOT in (select accountcode from t0) group by vo.AccountCode  
        union all  select distinct vo.AccountCode,sum(vo.jfje)jfje,sum(vo.dfje)dfje  from t2  vo   where  (fllx=1 or fllx=2) 			and (syjz!=1 or ACCOUNTCODE in(select accountcode from t0))			group by AccountCode )
update acc set acc.jfje=tv.jfje,acc.dfje=tv.dfje from dbo.TBDetail	acc with(nolock) join t3	tv on acc.accountcode=tv.AccountCode	and acc.isaux=0	and	acc.auxiliarycode=''	and acc.datatype=0


IF object_id('tempdb..#auxje')  IS NOT NULL DROP TABLE #auxje

;with  t10 as (select projectid,accountcode from account with(nolock)  where accountname='以前年度损益调整'	UNION ALL select  a.projectid,a.accountcode from account a with(nolock) inner join t10 on a.uppercode=t10.accountcode    and a.accountcode!=a.accountcode)
,t11 as(select accountcode,syjz from dbo.Account where Syjz=0)
,t12 as(select v.accountcode,v.FDetailID ,v.fllx,v.jfje,v.dfje,t11.syjz from dbo.tbvoucher v  with(nolock)   join  t11 on t11.accountcode  = v.AccountCode  where v.date<@pzEndDate)
,t13 as( select	distinct	vo.AccountCode,vo.FDetailID,sum(vo.jfje)jfje,sum(vo.dfje)dfje 	from t12	vo where vo.fllx=1 and vo.syjz=1 		AND	ACCOUNTCODE NOT in (select accountcode from t10)	group by vo.AccountCode,vo.FDetailID
	union all select	distinct	vo.AccountCode,vo.FDetailID,sum(vo.jfje)jfje,sum(vo.dfje)dfje 	from t12	vo 	WHERE (vo.FLLX=1 OR vo.FLLX=2) 			and (syjz!=1 or ACCOUNTCODE in(select accountcode from t10))	group by vo.AccountCode,vo.FDetailID )
,t14 as ( select af.accountcode,af.AuxiliaryCode,sum(v.jfje)jfje,sum(v.dfje)dfje     from dbo.AuxiliaryFDetail af with(nolock)    inner join t13 v    on V.AccountCode=AF.accountcode AND AF.FDetailID=V.FDetailID AND AF.DATATYPE=0     group by af.accountcode,af.AuxiliaryCode  )  
select ROW_NUMBER() OVER (ORDER BY accountcode) AS ID, accountcode,AuxiliaryCode,jfje,dfje into #auxje from t14 

update  aux set aux.jfje=0,aux.dfje=0  from	dbo.TbAux aux  inner join #auxje AV on av.AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS=aux.AccountCode  COLLATE Chinese_PRC_CS_AS_KS_WS  

update  aux set aux.jfje=isnull(av.jfje,0),aux.dfje=isnull(av.dfje,0)  from	dbo.TbAux aux  inner join #auxje AV on av.AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS=aux.AccountCode  COLLATE Chinese_PRC_CS_AS_KS_WS 
	and av.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS=aux.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS 

update ac1 set ac1.jfje1=ac2.jfje,ac1.dfje1=ac2.dfje From dbo.TBDetail ac1	with(nolock)  Inner join TBDetail ac2  with(nolock)  	on ac1.accountcode=ac2.accountcode	 and ac2.isaux=0 Where   ac1.isaux=0

Update dbo.TBDetail set jfje2=jfje-jfje1,dfje2=dfje-dfje1  where   isaux=0
 
select ROW_NUMBER() OVER (ORDER BY accountcode) AS ID,accountcode,fscode,kmsx,yefx          into #unauxje          from dbo.TbDetail with(nolock)       where auxiliarycode='' and datatype=0 and isaux=0    
 

IF object_id('tempdb..#auxfscode')  IS NOT NULL DROP TABLE #auxfscode
select ROW_NUMBER() OVER (ORDER BY accountcode) AS ID,accountcode,fscode,kmsx,yefx 
into #auxfscode	from	dbo.TbDetail with(nolock) where	auxiliarycode='' and	datatype=0 and	isaux=0	 									
MERGE DBO.TBAux AS AUX
USING 	#auxfscode AS DET
ON AUX.ACCOUNTCODE COLLATE Chinese_PRC_CS_AS_KS_WS=DET.ACCOUNTCODE	COLLATE Chinese_PRC_CS_AS_KS_WS
WHEN MATCHED  
THEN UPDATE SET aux.fscode=det.fscode,aux.KMSX=det.kmsx,aux.yefx=det.yefx;
  --ByTBAuxUpdateTbDetailJFJEDFJE
update  ad set ad.jfje=isnull(av.jfje,0),ad.dfje=isnull(av.dfje,0) from	dbo.tbdetail ad	with(nolock) 
    inner join dbo.TbAux av	with(nolock) 
    on av.AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS=ad.AccountCode  COLLATE Chinese_PRC_CS_AS_KS_WS
	and av.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS=ad.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS   
 
 end
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE type = 'P' AND name = 'InitTbAccTable')
   BEGIN
       DROP  Procedure  InitTbAccTable
	END
GO

CREATE Procedure [dbo].[InitTbAccTable](	@ProjectID nvarchar(50))
AS
begin try	
SET NOCOUNT ON
SET XACT_ABORT ON
truncate table tbdetail
declare @tempTable1 table 
(
	id int identity(1,1),
    AccountCode  varchar(255) collate Chinese_PRC_CS_AS_KS_WS,
    AccountName varchar(255),
    Fs  varchar(255),
    FsCode varchar(255) collate Chinese_PRC_CS_AS_KS_WS,
    Yefx int,
	Kmsx int
)insert into @tempTable1
select distinct C.Accountcode,C.AccountName,G.FsName,G.FsCode,G.Yefx,G.kmsx from dbo.TBFS G with(nolock)
inner join dbo.account C with(nolock) on (C.AccountName = G.FsName) --此处不能使用like语法及实际业务冲突
where (C.Jb=1) and G.ismx=1 
insert into @tempTable1
select distinct C.AccountCode,C.AccountName,F.Fs,G.FsCode,G.Yefx,G.Kmsx
From dbo.account C with(nolock),	EASKmdzb F with(nolock) ,	dbo.TBFS G with(nolock)
where   	  (C.AccountName = F.Note)--此处不能使用like语法及实际业务冲突
 and (F.Fs=G.FsName) and (C.jb=1) and G.ismx=1
 and C.AccountName not in (select AccountName from @tempTable1) --以避免与第一段insert into @tempTable1插入数据重复
 select distinct NEWID() IID ,DB_NAME() AS projectid,a.AccountCode,space(0) AS AuxiliaryCode,space(0) AS SourceFSCode,
 a.AccountName as AccAuxName,a.jb as TBType,0 AS IsMx,isnull(a.UpperCode,isnull(b.fscode,space(0))) TBGrouping,a.Ncye AS Sqqmye,
isnull(b.FsCode,space(0))fscode,isnull(b.yefx,1)yefx,isnull(b.kmsx,0)kmsx,0 AS isAux,a.ismx AS isAccMx,0 AS DataType
into #p1  from dbo.Account	a with(nolock)
left	join	@tempTable1	b
on left(a.accountcode,len(b.accountcode)) collate Chinese_PRC_CS_AS_KS_WS=b.AccountCode collate Chinese_PRC_CS_AS_KS_WS  
alter table #p1 add ID int IDENTITY(1,1)
declare @leve int=1000
declare @ix int=1
declare @ixend int=@leve 
while (1=1)begin
		insert into dbo.TBDetail (ID,projectid,AccountCode,AuxiliaryCode,SourceFSCode,AccAuxName,TBType,IsMx,TBGrouping,Sqqmye,
		fscode,yefx,kmsx,isAux,isAccMx,DataType)
		select IID,projectid,AccountCode,AuxiliaryCode,SourceFSCode,AccAuxName,TBType,IsMx,TBGrouping,Sqqmye,
			fscode,yefx,kmsx,isAux,isAccMx,DataType
				from #p1
					where id BETWEEN @ix	and @ixend
	if @@ROWCOUNT=0
		break;
	set @ix+=@leve 
	set	@ixend+=@leve 
end

END TRY

BEGIN CATCH
	EXEC DBO.[PRO_THROW]  'th','InitTbAccTable'
END CATCH





GO

