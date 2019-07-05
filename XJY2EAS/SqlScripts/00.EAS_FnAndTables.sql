

if exists (select 1
            from  sysobjects
           where  id = object_id('kjqj')
            and   type = 'U')
   drop table kjqj

CREATE TABLE kjqj    (      ProjectID VARCHAR(100) NOT NULL    , KJDate    VARCHAR(4) NOT NULL    , CONSTRAINT PK_KJQJ PRIMARY KEY(ProjectID, KJDate)    )
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
  Project   : EAS -�쳣����
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

	--@ERROR_NUMBER	int,--���ش����
	--@ERROR_SEVERITY	int,--����������
	--@ERROR_STATE		int,--���ش���״̬��
	@ERROR_PROCEDURE	VARCHAR(255)--���س��ִ���Ĵ洢���̻� ������������
	--@ERROR_LINE	int,--���ص��´���������е��� ��
	--@ERROR_MESSAGE	VARCHAR(1000)	--���ش�����Ϣ�������ı�
AS 
BEGIN
if (OBJECT_id('LogTable') is NULL)	
BEGIN	--create table logtable
	CREATE TABLE LogTable
	( 
	  ID              int identity(1,1),--�������
	  Projectid	VARCHAR(1000),
	  ErrorDateTime	DATETIME NOT NULL,
	  ErrorNumber     int,--�����
	  ErrorSeverity   int,--������
	  ErrorState      int,--����״̬��
	  ErrorProducure  varchar(255),--���ִ���Ĵ洢���̻� ������������
	  ErrorLine       int,--���´���������е��к�
	  ErrorMessage    varchar(1000)--������Ϣ�������ı�
)END

INSERT INTO LogTable values(@pid,GETDATE(),ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),@ERROR_PROCEDURE,ERROR_LINE(),ERROR_MESSAGE())

END


GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE type = 'P' AND name = 'BulkImportLocalPeriodData')
   BEGIN
       DROP  Procedure  BulkImportLocalPeriodData
	END
GO

CREATE PROCEDURE [dbo].BulkImportLocalPeriodData
	@ProjectID	varchar(100)
	,@Clientid	varchar(100)
	,@period	datetime	--������Ŀ��ֹ��
AS
BEGIN TRY	
--BEGIN	TransAction
SET NOCOUNT ON
SET XACT_ABORT ON

	declare @sql	nvarchar(max)
	declare @ProjectType        nvarchar(1000)=@ProjectID+'ProjectType';
	declare @Project            nvarchar(1000)=@ProjectID+'Project';
	declare @Account            nvarchar(1000)=@ProjectID+'Account';
	declare @Voucher            nvarchar(1000)=@ProjectID+'Voucher';
	
	declare	@upyearpid varchar(100),@currentyearpid	varchar(100)
	select @upyearpid=upperyearProjectid,@currentyearpid=currentyearpid 
		from neweasv5..projectsinfo	where projectid=@ProjectID
	
	--����ǰ��--�����
	create table #lastacc (accountcode varchar(1000) COLLATE Chinese_PRC_CS_AS_KS_WS	NULL,syjz int)
	if(@currentyearpid is not null and @currentyearpid!='')begin
		insert #lastacc
		select accountcode ,syjz from dbo.Account with(nolock) where Projectid=@currentyearpid
	end else if(@upyearpid is not null and @upyearpid!='')begin
		insert #lastacc
		select accountcode ,syjz from dbo.Account with(nolock) where Projectid=@upyearpid
	end 
	
	create table	#tmp	(ProjectID varchar(100),period	datetime)
	insert	#tmp	
	select @ProjectID,@period

	set @sql='
	
	SET ROWCOUNT 10000;
    WHILE 1 = 1
    BEGIN
	declare @ii int=0;
		
		delete dbo.ProjectType	where	ProjectID='''+@ProjectID+'''
		set @ii+=@@ROWCOUNT
		delete dbo.Project		where	ProjectID='''+@ProjectID+'''
		set @ii+=@@ROWCOUNT
		delete dbo.Account		where	ProjectID='''+@ProjectID+'''
		set @ii+=@@ROWCOUNT
		delete from dbo.TBVOUCHER	where ProjectID='''+@ProjectID+'''
		set @ii+=@@ROWCOUNT
		IF @ii = 0
			BREAK;
	END
    SET ROWCOUNT 0;

	declare	@currentyearPeriodEndDate	datetime=space(0)
	declare @currentyearpid	varchar(100)
	select @currentyearpid=currentyearpid
		from neweasv5..projectsinfo	where projectid='''+@ProjectID+'''
	
	if len(ISNULL(@currentyearpid,space(0)))>0
		select @currentyearPeriodEndDate=periodenddate from neweasv5..projectsinfo 
																		where projectid=@currentyearpid	
	
	insert	ProjectType(ProjectID,typecode,typename)
	select distinct '''+@ProjectID+''',typecode,typename from '+@ProjectType+'

	insert	Project(ProjectID,typecode,projectcode,projectname,uppercode,jb,ismx)
	select distinct '''+@ProjectID+''',typecode,projectcode,isnull(projectname,space(0)),uppercode,jb,ismx from '+@Project+'

	select DISTINCT	a.accountcode,ac.syjz
		into #tmp222
			from '+@Account+' a 
			inner join	neweasv5.dbo.Accountclass ac with(nolock)
			on a.Accountname like ac.AccountName+''%''
			where a.jb=1	
	
	insert	#tmp222
	select	DISTINCT a.accountcode,b.syjz
			from '+@Account+' a 
			inner join	#tmp222	b 
			on	left(a.accountcode,len(b.accountcode))=b.accountcode
			where a.jb>1

	insert	Account(ProjectID,[AccountCode],[AccountName],[jd],[hsxms],[TypeCode],[IsMx],[Ncye],[Jfje],[Dfje],[Ncsl],jb,syjz)
	select	distinct '''+@ProjectID+''',a.[AccountCode],[AccountName],[jd],[hsxms],[TypeCode],[IsMx],
											sum([Ncye]),sum([Jfje]),sum([Dfje]),sum([Ncsl]),jb,isnull(isnull(t1.syjz,t.syjz),0)syjz
		from '+@Account+'	a
		left join	#tmp222	t
		on a.AccountCode=t.accountcode
		left join	#lastacc	t1
		on a.AccountCode=t1.accountcode
			group by a.[AccountCode],[AccountName],[jd],[hsxms],[TypeCode],[IsMx],JB,t.syjz,t1.syjz
	
	select '''+@Clientid+''' as Clientid,'''+@ProjectID+''' as ProjectID,IncNo,Date, year(Date)*100+month(Date) as Period,Pzlx,Pzh,Djh,AccountCode,ProjectCode,Zy,Jfje,Dfje,Jfsl,Dfsl,
			zdr,dfkm,FDetailID,0 as fsje,0 as Hl,0 as jd
		into #p1
		from '+@Voucher+'	,#tmp
		where	[date]<=#tmp.period	and year([date])=year(#tmp.period)
	
	--�ֶ����
	if (len(isnull(@currentyearPeriodEndDate,space(0)))>0)begin
		Truncate table  #p1
		insert	 #p1
		select '''+@Clientid+''' as Clientid,'''+@ProjectID+''' as ProjectID,IncNo,Date, year(Date)*100+month(Date) as Period,Pzlx,Pzh,Djh,AccountCode,ProjectCode,Zy,Jfje,Dfje,Jfsl,Dfsl,
			zdr,dfkm,FDetailID,0 as fsje,0 as Hl,0 as jd
		from '+@Voucher+'	,#tmp
		where	[date]<=#tmp.period	and [date]>@currentyearPeriodEndDate	and year([date])=year(#tmp.period)	
	end
	
	alter table #p1 add ID int IDENTITY(1,1)

	declare @leve int=10000
	declare @ix int=1
	declare @ixend int=@leve 
	while (1=1)begin
		insert	dbo.TBVOUCHER(Clientid,ProjectID,IncNo,Date,Period,Pzlx,Pzh,Djh,AccountCode,ProjectCode,Zy,Jfje,Dfje,Jfsl,Dfsl,zdr,dfkm,FDetailID,fsje,Hl,jd)
		select Clientid,ProjectID,IncNo,Date,Period,Pzlx,Pzh,Djh,AccountCode,ProjectCode,Zy,Jfje,Dfje,Jfsl,Dfsl,zdr,dfkm,FDetailID,
				case when jfje<>0	then 1 else -1 end *(Jfje+Dfje) as fsje,Hl,
				case when jfje<>0	then 1 else -1 end	as jd
			 from #p1			where id BETWEEN @ix	and @ixend
		
		if @@ROWCOUNT=0
			break;
		set @ix+=@leve 
		set	@ixend+=@leve 
	end

	'
	exec(@sql)
	
	update dbo.tbwlzl		set	AgeAnalysis=0,BalanceAnalysis=0	where projectid=@ProjectID
	
	--����account.uppercode
	exec dbo.UpdateAccountUpperCodeLevel1 @ProjectID
	
	exec dbo.UpdateAccountPeriod @ProjectID,0

	set @sql='
	drop table	'+@ProjectType+'
	drop table	'+@Project+'
	drop table	'+@Account+'
	drop table	'+@Voucher+'
	'
	exec (@sql)
	
	--Commit TransAction
end try
begin catch
	
	--ROLLBACK TransAction
	EXEC DBO.[PRO_THROW] @ProjectID,'BulkImportLocalPeriodData'
end catch


GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE type = 'P' AND name = 'UpdateAccountUpperCodeLevel1')
   BEGIN
       DROP  Procedure  UpdateAccountUpperCodeLevel1
	END
GO
/********************************************************************************
  Database  : EAS
  Copyright : 2010 Huapu (Beijing)
  Customer  : 
  Project   : EAS -����Account�е�UppderCode��jb,ISmx�ֶ�ֵ  STEP TWO
  Created   : 2011/05/24 by dengll,rshibin
  Version   : 1.0.8
********************************************************************************/
CREATE Procedure UpdateAccountUpperCodeLevel1
	@ProjectID nvarchar(50)
AS

BEGIN TRY
--BEGIN	TransAction
SET NOCOUNT ON
SET XACT_ABORT ON

declare	@km	varchar(1000)=@ProjectID+'km'
UPDATE ACCOUNT SET UpperCode=NULL WHERE ProjectID=@ProjectID;

declare	@isFParentID	int=0;
if exists(select * 
	from syscolumns 
	where id=object_id(@km) and lower([name])='FParentID')
	set	@isFParentID=1;

--�������FParentid�ֶ��п��԰��¼�Ԫ�����������¼���ϵ.by dengll 20180120
IF	(@isFParentID=1)begin
	declare	@sql	nvarchar(max)
	set	@sql='
		
		----��ǰ��ȡ������,������²����κθ�������
		UPDATE DBO.ACCOUNT SET Attribute=1
		WHERE ProjectID='''+@ProjectID+''' AND 1!=1

		update	a set a.UpperCode=c.kmdm_jd
		from	dbo.account	a
		left	join	'+@km+'	b
		on a.accountcode	COLLATE Chinese_PRC_CS_AS_KS_WS	=b.kmdm_jd	COLLATE Chinese_PRC_CS_AS_KS_WS
		left	join	'+@km+'	c
		on	b.FParentID	COLLATE Chinese_PRC_CS_AS_KS_WS=c.FAccountID	COLLATE Chinese_PRC_CS_AS_KS_WS
		where	a.projectid='''+@ProjectID+'''
	'

	exec(@sql)
end 
else begin
--����¼�Ԫû��FParentID��Ҫ�Լ������������¼���ϵ
set nocount on

DECLARE @minLen INT
SELECT @minLen=MIN(LEN(accountCode)) FROM dbo.ACCOUNT with(nolock) WHERE ProjectID=@projectid
;
DECLARE @a1 TABLE(ID int IDENTITY(1,1),accountcode VARCHAR(100) COLLATE Chinese_PRC_CS_AS_KS_WS,uppercode VARCHAR(100) COLLATE Chinese_PRC_CS_AS_KS_WS,jb INT)
	;
INSERT @a1
SELECT accountcode,null,1
			FROM dbo.ACCOUNT with(nolock) WHERE ProjectID=@projectid AND LEN(accountcode)=@minLen

DECLARE @a2 TABLE(accountcode VARCHAR(100)COLLATE Chinese_PRC_CS_AS_KS_WS,lens int)

INSERT @a2
SELECT DISTINCT accountcode,len(accountcode)lens FROM dbo.Account with(nolock) WHERE ProjectID=@projectid	GROUP BY accountcode
DECLARE @jb INT=0
WHILE (1=1)BEGIN
	;
	WITH a3 AS (
		SELECT * from	@a2	WHERE accountcode NOT IN (SELECT accountcode FROM @a1))
	,a2 AS (SELECT * FROM a3	WHERE lens <= (SELECT MIN(lens)lens FROM a3))

	INSERT @a1		
	SELECT  a.AccountCode,aa.accountcode AS uppercode,aa.jb+1 AS jb 
	FROM  a2 a
	INNER JOIN @a1 aa
	ON  a.AccountCode LIKE aa.accountcode+'%'
	WHERE   aa.jb=@jb+1  
	IF @@ROWCOUNT=0
		BREAK;
	SET @jb=@jb+1	
END

--update account
declare @leve int=1000
declare @ix int=1
declare @ixend int=@leve 

while (1=1)begin
	update a set a.uppercode=b.uppercode
		from	dbo.Account  a
		inner join (select * from 	@a1 where id BETWEEN @ix	and @ixend)b
		on a.AccountCode collate Chinese_PRC_CS_AS_KS_WS=b.accountcode collate Chinese_PRC_CS_AS_KS_WS
		where a.projectid=@ProjectID
	
	if @@ROWCOUNT=0
		break;
	set @ix+=@leve 
	set	@ixend+=@leve 
end


---���䴦��uppercodeΪNull��accountcode, ��Ҫ������accountcode���̲�ͳһ����
DECLARE @a3 TABLE (accountcode VARCHAR (100) COLLATE Chinese_PRC_CS_AS_KS_WS, 
	uppercode VARCHAR (100) COLLATE Chinese_PRC_CS_AS_KS_WS, 
	jb INT)

INSERT @a3
SELECT accountcode,NULL,jb FROM dbo.ACCOUNT with(nolock) WHERE ProjectID=@projectid and Jb>1 AND UpperCode IS NULL

IF EXISTS(SELECT 1 FROM @A3)BEGIN

	DECLARE @a4 TABLE (accountcode VARCHAR (100)  COLLATE Chinese_PRC_CS_AS_KS_WS, 
		uppercode VARCHAR (100)  COLLATE Chinese_PRC_CS_AS_KS_WS, 
		jb INT)
	
	CREATE TABLE #account (ID int IDENTITY(1,1),accountcode VARCHAR(100) COLLATE Chinese_PRC_CS_AS_KS_WS,
		uppercode VARCHAR(100) COLLATE Chinese_PRC_CS_AS_KS_WS,jb INT)
	
	INSERT @a4
	SELECT accountcode,uppercode,jb FROM dbo.ACCOUNT WHERE len(accountcode)<(SELECT min(len(accountcode)) FROM @a3)

	;WITH a1 AS(
		SELECT accountcode,uppercode,jb FROM @a4
		UNION ALL
		SELECT a.accountcode,b.accountcode AS uppercode,a.jb FROM	@a3 a 
		inner JOIN  dbo.ACCOUNT 	b	with(nolock)
		ON a.accountcode!=b.accountcode AND
			 a.accountcode LIKE b.accountcode+'%'
		where a.jb=b.jb+1	and b.projectid=@ProjectID
	)

	insert #account
	select accountcode,uppercode,jb from a1	--where  AccountCode LIKE '6602%';

	set @leve =1000
	set @ix =1
	set @ixend =@leve 

	while (1=1)begin
		update a set a.uppercode=b.uppercode
			from	dbo.Account  a
			inner join (select * from 	#account where id BETWEEN @ix	and @ixend)b
			on a.AccountCode collate Chinese_PRC_CS_AS_KS_WS=b.accountcode collate Chinese_PRC_CS_AS_KS_WS
			where a.projectid=@ProjectID
	
		if @@ROWCOUNT=0
			break;
		set @ix+=@leve 
		set	@ixend+=@leve 
	end
	drop table #account
end	

end

--Commit TransAction
end try
begin catch
	EXEC DBO.[PRO_THROW] @ProjectID,'UpdateAccountUpperCodeLevel1'
end catch


GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE type = 'P' AND name = 'UpdateAccountPeriod')
   BEGIN
       DROP  Procedure  UpdateAccountPeriod
	END
GO

CREATE  PROCEDURE [dbo].UpdateAccountPeriod  
 @ProjectID varchar(100),  
 @dateType int  
AS  
BEGIN TRY   
--BEGIN TransAction  
SET NOCOUNT ON  
SET XACT_ABORT ON  
  
declare @PeriodTable table(Period int,StartDate datetime,EndDate datetime)  
declare @i int=1;  
declare @kjdate varchar(10);  
select top 1 @kjdate=kjdate from dbo.kjqj --where ProjectID=@ProjectID  
while(@i<=12)begin  
 declare @date varchar(10)  
 if(@i>9)  
  set @date=@kjdate+cast(@i as varchar(2))+'01'  
 else   
  set @date=@kjdate+'0'+cast(@i as varchar(2))+'01'  
  
 INSERT @PeriodTable  
 select cast(CONVERT(char(6),@date,112) as int),   
 convert(varchar(10),DATEADD(mm, DATEDIFF(mm,0,@date), 0),111),  
 CONVERT(varchar(10),DATEADD(ms,-3,DATEADD(mm, DATEDIFF(m,0,@date)+1, 0)),111)  
 set @i=@i+1  
end  
  
if(@dateType!=0)  
delete dbo.accountperiod where ProjectID=@ProjectID   
  and DateType=@dateType and year(StartDate)=year(@kjdate)  
else   
 delete dbo.accountperiod where ProjectID=@ProjectID and DateType=@dateType  
  
insert into dbo.accountperiod(ProjectID,accountperiod,Period,StartDate,EndDate,DateType,currentyearPID)  
select @ProjectID,B.Period,0, B.StartDate, B.EndDate,@dateType ,@ProjectID  
from  @PeriodTable B where not exists  
(select  A.accountperiod from  dbo.accountperiod A where  B.period = A.accountperiod )  
--Commit TransAction  
end try  
begin catch  
--ROLLBACK TransAction  
 EXEC DBO.[PRO_THROW] @ProjectID,'UpdateAccountPeriod'  
end catch  
  