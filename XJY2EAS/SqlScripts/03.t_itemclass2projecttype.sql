
 delete EAS_PROJECTTYPE 
--begin 构造project表数据(项目核算)  
IF EXISTS(SELECT 1 FROM XM)
BEGIN  
 INSERT EAS_PROJECTTYPE
 SELECT  FITEMID,FName FROM t_itemclass
END  

update  EAS_PROJECTTYPE set TypeCode=LTRIM(rtrim(TypeCode))   