 
delete  EAS_PROJECT 
  
INSERT  EAS_PROJECT
   SELECT Distinct LEFT(XMDM,CHARINDEX('.',XMDM)),XMDM,XMMC,NULL,XMJB,XMMX  
   FROM XM ;  

update EAS_PROJECT set ProjectCode=LTRIM(rtrim(ProjectCode)),TypeCode=LTRIM(rtrim(TypeCode))  
 
  
 