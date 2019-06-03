declare  @ProjectID varchar(100) ='EAS_'  ,@dataType int=0 --0 本期，1前期,-1期后     
--declare @t_itemclass varchar(1000)=@ProjectID+'t_itemclass'        
--declare @t_fzye varchar(1000)=@ProjectID+'t_fzye'        
--declare @t_itemdetail varchar(1000)=@ProjectID+'t_itemdetail'        
--declare @km varchar(1000)=@ProjectID+'km'        
--declare @xm varchar(1000)=@ProjectID+'xm'        
--declare @xmye varchar(1000)=@ProjectID+'xmye'         
--DECLARE @ID INT,@COUNT INT,@T1 VARCHAR(255),@A VARCHAR(255),@sql nvarchar(max)        
        
--如果不存在return  
if object_id(t_itemclass) is null  
 return;  
  		
IF OBJECT_ID('tempdb..#tmp') IS NOT NULL        
 DROP TABLE #tmp        
create table #tmp(fname varchar(1000))        
        
DECLARE @FNAME VARCHAR(1000)=''        
		DECLARE @fid varchar(100)        
 SELECT @fid= stuff ((SELECT ';'+CAST([FItemId] AS VARCHAR)        
   FROM  t_itemclass      
    FOR xml path ('')), 1, 1,'')        
 from t_itemclass   
 
 ;WITH A1 AS(        
 SELECT  'ltrim(rtrim(ISNULL(F'+CAST(t.FItemClassID AS VARCHAR(100))+','+'space(0)'+')))' AS FT FROM t_itemclass t        
 INNER JOIN DBO.fn_SplitTSQL(@fid,';') t1        
 ON  REPLACE(t.FItemId,' ','') COLLATE Chinese_PRC_CS_AS_KS_WS=REPLACE(t1.Code,' ','')) 
      
 insert #tmp        
 SELECT top 1 stuff ((SELECT '+'+Ft        
   FROM A1        
    FOR xml path ('')), 1, 1,'')        
 FROM A1;  

select @FNAME=isnull(fname,space(0)) from #tmp        
        print '@@FNAME: '+@FNAME  -- 调试  @FNAME
		    
if(dbo.isnullempty(@FNAME,'')!='') begin        
               
 declare @kjdate varchar(10);        
 select top 1 @kjdate=kjdate from dbo.kjqj where ProjectID= 'EAS_'     
    
 DECLARE @spl VARCHAR(10)=';'    
 IF EXISTS(Select 1 from  t_fzye)begin   
 if OBJECT_ID('tempdb..#itemdetailtable')  is not null drop table #itemdetailtable
  CREATE TABLE #itemdetailtable(kmdm varchar(1000) COLLATE Chinese_PRC_CS_AS_KS_WS NOT NULL,FDetailID int,    
   ProjectCode varchar(1000) COLLATE Chinese_PRC_CS_AS_KS_WS NULL)    
        
  declare @tt table(f varchar(1000));     
      
  insert @tt     
  SELECT 'ltrim(rtrim(ISNULL('+name+',space(0))))'    from sys.columns p where object_id = OBJECT_ID('t_itemdetail') and name not in ('FDetailID','Xmdm') 
  
  while exists(select 1 from @tt )begin    
   declare @xcode varchar(100)    
   select @xcode =f from @tt    
   
   declare @x1 nvarchar(max)='    
   insert #itemdetailtable           
   SELECT ltrim(rtrim(a.kmdm)),idet.FDetailID,'+@xcode+'    
      FROM  t_itemdetail idet    
      join  t_fzye a    
      on a.FDetailID=idet.FDetailID    
      where  '+@xcode+'!=space(0)'    
   exec(@x1)    
   delete @tt where f=@xcode    
  -- print @xcode 
  end    
     
  declare @dtype int=0      
  SET ROWCOUNT 5000;    
  declare @ii int=0    
  WHILE 1 = 1    
  BEGIN    
   set @ii =0;    
   delete dbo.AuxiliaryFDetail where projectid='EAS_'    and datatype=@dtype  and datayear=@kjdate    
   set @ii+=@@ROWCOUNT    
       
   if(@dtype=0)    
    delete dbo.tbaux where projectid='EAS_'    
   set @ii+=@@ROWCOUNT    
   IF @ii = 0    
    BREAK;    
  END    
  SET ROWCOUNT 0;    
  if OBJECT_ID('tempdb..#p1')  is not null drop table #p1
  CREATE TABLE #p1(ID int IDENTITY(1,1),accountcode varchar(100),AuxiliaryCode varchar(100)  COLLATE Chinese_PRC_CS_AS_KS_WS ,FDetailID int)    
      
  insert #p1    
  SELECT  DISTINCT kmdm,projectcode,FDetailID from #itemdetailtable  where projectcode!=space(0)     
     if OBJECT_ID('tempdb..#p2')  is not null drop table #p2
  SELECT distinct 'EAS_' as ProjectID,    idet.accountcode,idet.AuxiliaryCode,     isnull(xm.xmmc,space(0)) as AuxiliaryName,xmye.ncye as Sqqmye,0 as jfje,0 as dfje 
    INTO #p2   FROM (select distinct accountcode,AuxiliaryCode from #p1) idet   
  
  join  xm xm   on LTRIM(rtrim(xm.xmdm)) COLLATE Chinese_PRC_CS_AS_KS_WS=idet.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS   
      join  xmye xmye   on idet.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=ltrim(rtrim(xmye.kmdm)) COLLATE Chinese_PRC_CS_AS_KS_WS   
	    and idet.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS=LTRIM(rtrim(xmye.xmdm)) COLLATE Chinese_PRC_CS_AS_KS_WS   --
--group by idet.accountcode,idet.AuxiliaryCode,xm.xmmc    
    
  alter table #p2 add ID int IDENTITY(1,1)   
 -- select count(*) from #p1
   --select  count(*) from #p2
      
  declare @leve int=1000    
  declare @ix int=1    
  declare @ixend int=@leve     
      
  while (1=1)begin    
   set @ii =0;    
   insert dbo.AuxiliaryFDetail(projectid,accountcode,AuxiliaryCode,FDetailID,DataType,DataYear)    
   select 'EAS_',accountcode,AuxiliaryCode,FDetailID,@dtype,@kjdate from #p1 a    
    where (ID BETWEEN @ix and @ixend)     
    and not exists(select 1 from dbo.AuxiliaryFDetail     
     where projectid='EAS_' COLLATE Chinese_PRC_CS_AS_KS_WS     
      and accountcode=a.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS    
      and AuxiliaryCode=a.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS    
      and FDetailID=a.FDetailID    
      and DataType=@dtype    
      and DataYear=@kjdate)    
       
   set @ii+=@@ROWCOUNT    
       
   if(@dtype=0)    
    insert dbo.TBAux(ProjectID,fscode, AccountCode, AuxiliaryCode, AuxiliaryName, Sqqmye, jfje, dfje,qmye,kmsx,tbgrouping)    
    SELECT ProjectID,space(0), AccountCode, AuxiliaryCode,AuxiliaryName,Sqqmye,jfje,dfje,0,0,AccountCode     
     FROM  #p2 where ID BETWEEN @ix and @ixend    
       
   set @ii+=@@ROWCOUNT    
       
   if @ii=0    
    break;    
   set @ix+=@leve     
   set @ixend+=@leve     
  end    
      
 end    

 end

 --select count(1) from AuxiliaryFDetail
 --select count(1) from TBAux