 
DECLARE @ProjectID varchar(1000)  ='EAS_' 
   
 DECLARE @tabname varchar(1000),@sql nvarchar(max)  
 set @tabname =@ProjectID+'PROJECTTYPE';  
 IF object_id(@tabname ) IS NOT NULL  
  exec('DROP TABLE '+@tabname );  
  
 set @sql='  
 CREATE TABLE '+@tabname+' (  
  ID INT IDENTITY(1, 1)  
  ,TYPECODE VARCHAR(1000) COLLATE Chinese_PRC_CS_AS_KS_WS NULL  
  ,TYPENAME VARCHAR(1000)   
  )'  
 exec(@sql)  
  
 set @tabname =@ProjectID+'PROJECT';  
 IF object_id(@tabname) IS NOT NULL  
  EXEC('DROP TABLE '+@tabname);  
 set @sql='  
 CREATE TABLE '+@tabname+' (  
  TYPECODE VARCHAR(1000) COLLATE Chinese_PRC_CS_AS_KS_WS NOT NULL  
  ,PROJECTCODE VARCHAR(1000) COLLATE Chinese_PRC_CS_AS_KS_WS NOT NULL  
  ,PROJECTNAME VARCHAR(1000)  null  
  ,UPPERCODE VARCHAR(1000) COLLATE Chinese_PRC_CS_AS_KS_WS  NULL  
  ,JB INT  
  ,ISMX INT  
  )'  
 exec(@sql)  
 set @tabname =@ProjectID+'ACCOUNT';  
 IF object_id(@tabname) IS NOT NULL  
  EXEC('DROP TABLE '+@tabname);  
  
 set @sql='  
 CREATE TABLE '+@tabname+' (  
  [AccountCode] [varchar](1000)   COLLATE Chinese_PRC_CS_AS_KS_WS NOT NULL  
  ,[AccountName] [varchar](1000)  NULL  
  ,[Attribute] [int] NULL  
  ,[Jd] [int] DEFAULT(1)  
  ,[Hsxms] [int] NOT NULL DEFAULT(0)  
  ,[TypeCode] [varchar](1000) COLLATE Chinese_PRC_CS_AS_KS_WS NULL  
  ,[Jb] [int] DEFAULT(1)  
  ,[IsMx] int  
  ,[Ncye]  [decimal](20, 2) DEFAULT((0))  
  ,[Qqccgz]  [decimal](20, 2) DEFAULT((0))  
  ,[Jfje]  [decimal](20, 2) DEFAULT((0))  
  ,[Dfje]  [decimal](20, 2) DEFAULT((0))  
  ,[Ncsl]  int DEFAULT((0))  
  )'  
 exec(@sql)  
  
 set @tabname =@ProjectID+'Voucher';  
 IF object_id(@tabname) IS NOT NULL  
  EXEC('DROP TABLE '+@tabname);  
  
 set @sql='  
 CREATE TABLE '+@tabname+' (  
  [IncNo] INT null  
  ,[Date] VARCHAR(1000) NULL  
  ,[Period] [int] NULL  
  ,[Pzlx] [varchar](1000)  NULL  
  ,[Pzh] [varchar](255)  NULL  
  ,[Djh] [int] NULL  
  ,[AccountCode] [varchar](1000)  COLLATE Chinese_PRC_CS_AS_KS_WS NOT NULL  
  ,[ProjectCode] [varchar](1000) COLLATE Chinese_PRC_CS_AS_KS_WS NULL  
  ,[Zy] [varchar](1000)  NULL  
  ,[Jfje] [decimal](20, 2) NULL  
  ,[Dfje] [decimal](20, 2) NULL  
  ,[Jfsl] [decimal](20, 4) NULL  
  ,[Dfsl] [decimal](20, 4) NULL  
  ,[ZDR] [varchar](1000) NULL  
  ,[DFKM] [varchar](100) NULL  
  ,[FDetailID] INT NULL  
  ,[KMDM_jd] varchar(100) null  
  );'  
 exec(@sql)  
  
 set @tabname =@ProjectID+'t_fzye_t';  
 IF object_id(@tabname) IS NOT NULL  
  EXEC('DROP TABLE '+@tabname);  
  
 set @sql='  
 CREATE TABLE  '+@tabname+'(  
    ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,  
    AccountCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,  
    FDetailID            int                  not null,  
    ProjectCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null default space(0),  
    Yefx                 varchar(255)         null,  
    Ncye                 decimal(20,2)        null,  
    Ncsl                 float                null,  
    datatype             int                  not null default 0,  
    DataYear             int                  not null default 1999,  
 );'  
 exec(@sql)  
  
 set @tabname =@ProjectID+'TBAux';  
 IF object_id(@tabname) IS NOT NULL  
  EXEC('DROP TABLE '+@tabname);  
 set @sql='  
  
 CREATE TABLE  '+@tabname+'  
 (  
  ProjectID VARCHAR (100) COLLATE Chinese_PRC_CS_AS_KS_WS NULL,  
  AccountCode VARCHAR (100) COLLATE Chinese_PRC_CS_AS_KS_WS NULL,  
  AuxiliaryCode VARCHAR (100) COLLATE Chinese_PRC_CS_AS_KS_WS NULL,  
  AuxiliaryName VARCHAR (100) COLLATE Chinese_PRC_CS_AS_KS_WS NULL,  
  FSCode VARCHAR (50) COLLATE Chinese_PRC_CS_AS_KS_WS NULL,  
  kmsx VARCHAR (100),  
  YEFX INT,  
  TBGrouping NVARCHAR (50) COLLATE Chinese_PRC_CS_AS_KS_WS NULL,  
  Sqqmye DECIMAL (20, 2),  
  Qqccgz DECIMAL (20, 2),  
  jfje DECIMAL (20, 2),  
  dfje DECIMAL (20, 2),  
  qmye DECIMAL (20, 2)  
 )  
 '  
 --exec(@sql)  
 
 
if exists (select 1
            from  sysobjects
           where  id = object_id('AuxiliaryFDetail')
            and   type = 'U')
   drop table AuxiliaryFDetail

create table AuxiliaryFDetail (
   projectid            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Accountcode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Ncye					decimal(19,3)        null default(0),
   Jfje1				decimal(19,3)        null default(0),
   Dfje1				decimal(19,3)        null default(0),
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
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ACCOUNT')
            and   type = 'U')
   drop table ACCOUNT
go
create table ACCOUNT (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   UpperCode            varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   AccountName          varchar(1000)        not null,
   Attribute            int                  null,
   Jd                   int                  null,
   Hsxms                int                  not null,
   TypeCode             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   Jb                   int                  not null,
   IsMx                 int                  null,
   Ncye                 decimal(20,2)        null,
   Qqccgz               decimal(20,2)        null,
   Jfje                 decimal(20,2)        null,
   Dfje                 decimal(20,2)        null,
   Ncsl                 int                  null,
   Syjz                 int                  not null default 0,
   constraint PK_ACCOUNT primary key (ProjectID, AccountCode)
)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TBVoucher')
            and   type = 'U')
   drop table TBVoucher
go
create table dbo.TBVoucher (
   VoucherID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null default newid(),
   Clientid             varchar(100)         not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   IncNo                varchar(50)          collate Chinese_PRC_CI_AS not null,
   Date                 datetime             not null,
   Period               int                  not null,
   Pzlx                 varchar(255)         collate Chinese_PRC_CI_AS null,
   Pzh                  varchar(255)         collate Chinese_PRC_CI_AS not null,
   Djh                  varchar(255)         null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   Zy                   varchar(Max)         collate Chinese_PRC_CI_AS null,
   Jfje                 decimal(20,2)        not null,
   Dfje                 decimal(20,2)        not null,
   Jfsl                 decimal(20,4)        not null,
   Dfsl                 decimal(20,4)        not null,
   ZDR                  varchar(255)         collate Chinese_PRC_CI_AS null,
   dfkm                 varchar(200)         collate Chinese_PRC_CI_AS null,
   Jd                   int                  not null,
   Fsje                 decimal(20,2)        not null,
   Wbdm                 varchar(200)         collate Chinese_PRC_CI_AS null,
   Wbje                 decimal(20,4)        null,
   Hl                   decimal(20,4)        not null,
   FLLX                 int                  not null default (1),
   SampleSelectedYesNo  int                  not null default (0),
   SampleSelectedType   int                  not null default (0),
   TBGrouping           varchar(200)         null,
   EASREF               varchar(5)           collate Chinese_PRC_CI_AS null,
   AccountingAge        int                  not null default (0),
   qmyegc               int                  not null default (0),
   Stepofsample         int                  not null default (0),
   ErrorYesNo           int                  not null default (0),
   FDetailID            int                  null default -1,
   constraint PK_TBVoucher primary key (VoucherID)
         on "PRIMARY"
)
on "PRIMARY"
go
 

if exists (select 1
            from  sysobjects
           where  id = object_id('ProJect')
            and   type = 'U')
   drop table ProJect
go
create table ProJect (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TYPECODE             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   PROJECTCODE          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   PROJECTNAME          varchar(1000)        not null,
   UPPERCODE            varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   JB                   int                  null,
   ISMX                 int                  null,
   constraint PK_PROJECT primary key (ProjectID, TYPECODE, PROJECTCODE)
)
go
 

if exists (select 1
            from  sysobjects
           where  id = object_id('ProjectType')
            and   type = 'U')
   drop table ProjectType
go
create table ProjectType (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TYPECODE             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TYPENAME             varchar(1000)        not null,
   constraint PK_PROJECTTYPE primary key (ProjectID, TYPECODE)
)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Tbwlzl')
            and   type = 'U')
   drop table Tbwlzl
go

create table dbo.Tbwlzl (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   fsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AgeAnalysis          int                  not null default (0),
   ZLD1                 decimal(20,2)        not null default (0),
   ZLD2                 decimal(20,2)        not null default (0),
   ZLD3                 decimal(20,2)        not null default (0),
   ZLD4                 decimal(20,2)        not null default (0),
   ZLD5                 decimal(20,2)        not null default (0),
   ZLD6                 decimal(20,2)        not null default (0),
   ZLD7                 decimal(20,2)        not null default (0),
   ZLD8                 decimal(20,2)        not null default (0),
   ZLD9                 decimal(20,2)        not null default (0),
   significant          int                  not null default (0),
   Impairmenttestmethod int                  not null default (1),
   impairmentamount     decimal(20,2)        not null default (0),
   BalanceAnalysis      int                  not null default (0),
   memo                 varchar(500)         collate Chinese_PRC_CI_AS not null,
   HZZBZLD1             decimal(20,2)        not null default (0),
   HZZBZLD2             decimal(20,2)        not null default (0),
   HZZBZLD3             decimal(20,2)        not null default (0),
   HZZBZLD4             decimal(20,2)        not null default (0),
   HZZBZLD5             decimal(20,2)        not null default (0),
   HZZBZLD6             decimal(20,2)        not null default (0),
   HZZBZLD7             decimal(20,2)        not null default (0),
   HZZBZLD8             decimal(20,2)        not null default (0),
   HZZBZLD9             decimal(20,2)        not null default (0),
   Creditperiod         int                  not null default (0),
   constraint PK__TBwlzl primary key (ID, ProjectID)
         on "PRIMARY"
)
on "PRIMARY"
go


if exists (select 1
            from  sysobjects
           where  id = object_id('accountperiod')
            and   type = 'U')
   drop table accountperiod
go

create table accountperiod (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   accountperiod        int                  not null,
   Period               int                  not null,
   StartDate            datetime             not null,
   EndDate              datetime             not null,
   DateType             int                  not null,
   CurrentyearPID       varchar(100)         not null,
   constraint PK_ACCOUNTPERIOD primary key (ProjectID, accountperiod)
)
go
if exists (select 1
            from  sysobjects
           where  id = object_id('TBDetail')
            and   type = 'U')
   drop table TBDetail
go
create table TBDetail (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccAuxName           varchar(100)         collate Chinese_PRC_CI_AS not null,
   DataType             int                  not null,
   TBGrouping           varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TBType               int                  not null,
   IsAccMx              int                  not null,
   IsMx                 int                  not null,
   IsAux                Int                  not null,
   kmsx                 varchar(100)         collate Chinese_PRC_CI_AS not null,
   Yefx                 int                  not null default (1),
   SourceFSCode         varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Sqqmye               decimal(20,2)        not null default (0),
   Qqccgz               decimal(20,2)        not null default (0),
   jfje                 decimal(20,2)        not null default (0),
   dfje                 decimal(20,2)        not null default (0),
   CrjeJF               decimal(20,2)        not null default (0),
   CrjeDF               decimal(20,2)        not null default (0),
   AjeJF                decimal(20,2)        not null default (0),
   AjeDF                decimal(20,2)        not null default (0),
   RjeJF                decimal(20,2)        not null default (0),
   RjeDF                decimal(20,2)        not null default (0),
   TaxBase              decimal(20,2)        not null default (0),
   PY1                  decimal(20,2)        not null default (0),
   jfje1                decimal(20,2)        not null default (0),
   dfje1                decimal(20,2)        not null default (0),
   jfje2                decimal(20,2)        not null default (0),
   dfje2                decimal(20,2)        not null default (0),
   constraint PK_TBDETAIL primary key (ID, ProjectID)
)
go