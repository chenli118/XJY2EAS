
 delete EAS_PROJECTTYPE 
--begin ����project������(��Ŀ����)  
IF EXISTS(SELECT 1 FROM XM)
BEGIN  
 INSERT EAS_PROJECTTYPE
 SELECT  FITEMID,FName FROM t_itemclass
END  

update  EAS_PROJECTTYPE set TypeCode=LTRIM(rtrim(TypeCode))   