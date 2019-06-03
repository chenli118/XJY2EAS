 
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
