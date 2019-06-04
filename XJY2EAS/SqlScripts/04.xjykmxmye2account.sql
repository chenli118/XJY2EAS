  
delete EAS_ACCOUNT

INSERT EAS_ACCOUNT (ACCOUNTCODE,ACCOUNTNAME,[IsMx],Jb,Hsxms,ncye,ncsl)
SELECT Distinct _km.KMDM,_km.KMMC,_km.kmmx,_km.kmjb,0,  isnull(_kmye.ncye,0),  isnull(_kmye.ncsl,0)  
FROM KM  _km   left join kmye _kmye  
on _km.kmdm COLLATE Chinese_PRC_CS_AS_KS_WS =_kmye.kmdm COLLATE Chinese_PRC_CS_AS_KS_WS   
WHERE ISNUMERIC(LEFT(LTRIM(RTRIM(_km.KMDM)),1))=1 

IF OBJECT_ID('tempdb..#kmgroup') IS NOT  NULL  
 DROP TABLE #kmgroup  

 IF OBJECT_ID('tempdb..#kmx') IS NOT  NULL  
 DROP TABLE #kmx  

create table #kmx (kmdm VARCHAR(255)  COLLATE Chinese_PRC_CS_AS_KS_WS NOT NULL,typecode VARCHAR(255) COLLATE Chinese_PRC_CS_AS_KS_WS NULL)   
   
; 
with s1 as
(
SELECT DISTINCT _xmye.KMDM,_xmye.XMDM,icl.FITEMID as typecode FROM    XMYE _xmye   JOIN xm xm  
 ON _xmye.Xmdm COLLATE Chinese_PRC_CS_AS_KS_WS =xm.Xmdm COLLATE Chinese_PRC_CS_AS_KS_WS   
 INNER JOIN t_itemclass icl   ON LEFT(xm.Xmdm,LEN(icl.FItemId))=icl.FItemId 
)
INSERT #kmx  SELECT DISTINCT KMDM,typecode from s1


SELECT distinct kmdm , [val] = stuff ((SELECT ';'+b.typecode    FROM #kmx AS b        where b.kmdm=a.kmdm  
                          FOR xml path ('')  
                          ), 1, 1, ''  
                          )  into #kmgroup 
FROM #kmx AS a  
GROUP BY kmdm   

update a set   
 a.typecode=#kmgroup.[val]  
 from EAS_ACCOUNT a  
 left join #kmgroup  
 on a.accountcode=#kmgroup.kmdm COLLATE Chinese_PRC_CS_AS_KS_WS     

  
update EAS_ACCOUNT set hsxms=dbo.IndexSplterNumber(typecode,';')  
update EAS_ACCOUNT set TypeCode=LTRIM(rtrim(TypeCode))  

drop table #kmgroup 
drop table #kmx