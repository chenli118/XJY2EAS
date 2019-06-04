
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
go
if exists (select 1
            from  sysobjects
           where  id = object_id('kjqj')
            and   type = 'U')
   drop table kjqj

CREATE TABLE kjqj    (      ProjectID VARCHAR(100) NOT NULL    , KJDate    VARCHAR(4) NOT NULL    , CONSTRAINT PK_KJQJ PRIMARY KEY(ProjectID, KJDate)    )

if exists (select 1
            from  sysobjects
           where  id = object_id('AuxiliaryFDetail')
            and   type = 'U')
   drop table AuxiliaryFDetail

create table AuxiliaryFDetail (
   projectid            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Accountcode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FDetailID            int                  not null,
   DataType             int                  not null,
   DataYear             int                  not null,
   constraint PK_AUXILIARYFDETAIL primary key (projectid, Accountcode, AuxiliaryCode, FDetailID, DataYear)
)

if exists (select 1
            from  sysobjects
           where  id = object_id('TBAux')
            and   type = 'U')
   drop table TBAux

create table TBAux (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryName        varchar(100)         collate Chinese_PRC_CI_AS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   kmsx                 varchar(100)         collate Chinese_PRC_CI_AS not null,
   YEFX                 int                  not null default (1),
   TBGrouping           nvarchar(50)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Sqqmye               decimal(20,2)        not null default (0),
   Qqccgz               decimal(20,2)        not null default (0),
   jfje                 decimal(20,2)        not null default (0),
   dfje                 decimal(20,2)        not null default (0),
   qmye                 decimal(20,2)        not null default (0),
   constraint PK_TBAUX primary key (ProjectID, AccountCode, AuxiliaryCode)
)
