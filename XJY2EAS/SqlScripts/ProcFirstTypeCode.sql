
--默认处理第一个核算类型项目？

IF object_id('tempdb..#typcode')  IS NOT NULL DROP TABLE #typcode

SELECT a.projectid,a.accountcode,case when charindex(';',a.typecode)>0 then substring(a.TypeCode,0,charindex(';',a.typecode)) else a.TypeCode end TypeCode,
b.FSCode,b.kmsx,b.Yefx,b.Tbtype
INTO #typcode 
 FROM ACCOUNT a 
 INNER JOIN  TBDetail b
 ON  a.AccountCode=b.AccountCode 
 WHERE a.Hsxms>0	AND a.TypeCode!='' and b.DataType=0 and b.IsAux =0


IF object_id('tempdb..#aux')  IS NOT NULL DROP TABLE #aux

SELECT DISTINCT b.*,a.AuxiliaryCode,a.AuxiliaryName as AccAuxName,	(a.Sqqmye + a.QQccgz) AS Sqqmye,	a.jfje,a.dfje
	INTO #aux FROM TBAux a	INNER JOIN #typcode b	ON  a.AccountCode=b.accountcode	AND a.AuxiliaryCode LIKE b.TypeCode+'%'

IF object_id('tempdb..#fdetail')  IS NOT NULL DROP TABLE #fdetail 
SELECT a.projectid,a.Accountcode,a.AuxiliaryCode,a.FDetailID,a.DataYear,a.DataType 
	INTO #fdetail	FROM #aux o	INNER JOIN dbo.AuxiliaryFDetail a	ON  o.Accountcode=a.Accountcode	AND a.AuxiliaryCode=o.AuxiliaryCode	AND a.DataType=0

;with a1 as (SELECT projectid,Accountcode,AuxiliaryCode,fscode FROM dbo.TBDetail where datatype=0	and AuxiliaryCode<>'' 
	except   SELECT projectid,Accountcode,AuxiliaryCode,fscode FROM  #aux ) 

delete t1 from dbo.TBDetail t1 
	join a1 o 		on  o.AccountCode = t1.AccountCode 				and o.AuxiliaryCode = t1.AuxiliaryCode 	and o.FSCode = t1.FSCode  	and t1.DataType = 0


insert dbo.TBDetail(ID,ProjectID,FSCode,AccountCode, AuxiliaryCode, AccAuxName, DataType, TBGrouping, TBType, IsMx, IsAccMx, IsAux, kmsx, Yefx, Sqqmye, jfje, dfje,SourceFSCode)  

 select newid(), ProjectID,FSCode,AccountCode, AuxiliaryCode, AccAuxName, 		0 as DataType, AccountCode, TBType, 1, 0, 1, kmsx, Yefx, Sqqmye, jfje, dfje,'' 

			from   #aux t1 where not exists(select 1 from dbo.TBDetail o where   o.AccountCode = t1.AccountCode and o.AuxiliaryCode = t1.AuxiliaryCode and o.FSCode = t1.FSCode)  

update a set a.ismx=1 	from	 TBDetail a	inner join #typcode b		on   a.accountcode=b.accountcode and a.datatype=0



--UpdateVoucherProjectCode

if OBJECT_ID('tempdb..#tvdetail') IS NOT NULL  drop table #tvdetail   

select ROW_NUMBER() OVER (ORDER BY t.accountcode) AS ID,  t.fscode,  

 t.projectid, t.accountcode,t.auxiliaryCode,a.DataYear,a.FDetailID    

 into #tvdetail   from dbo.TBDetail t   inner join dbo.AuxiliaryFDetail a    

 on t.projectid=a.projectid and t.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=a.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS    

  and t.auxiliarycode COLLATE Chinese_PRC_CS_AS_KS_WS=a.auxiliarycode COLLATE Chinese_PRC_CS_AS_KS_WS    

  and a.datatype=0 

 where   t.datatype=0 and t.auxiliarycode!='' 
 
update v  set v.ProjectCode=a1.auxiliaryCode from dbo.TBVoucher v inner join #tvdetail a1 on v.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=a1.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS  and v.FDetailID=a1.FDetailID   
  


--UpdateTbDetailISMXISAUXISACCMX

IF object_id('tempdb..#TBGrouping1')  IS NOT NULL DROP TABLE #TBGrouping1

IF object_id('tempdb..#TBGrouping2')  IS NOT NULL DROP TABLE #TBGrouping2 

SELECT DISTINCT TBGrouping INTO #TBGrouping1 	FROM TBDetail  	WHERE   AuxiliaryCode = ''; 

SELECT DISTINCT TBGrouping INTO #TBGrouping2 	FROM TBDetail	  


UPDATE TBDetail 	SET IsAux = 0	WHERE  AuxiliaryCode = '';

UPDATE TBDetail 	SET IsAux = 1  	WHERE  AuxiliaryCode <> '';

UPDATE TBDetail 	SET IsAccMx = 0 	WHERE  (AuxiliaryCode <> ''			OR AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS IN (SELECT TBGrouping FROM #TBGrouping1));

UPDATE TBDetail 	SET IsAccMx = 1	WHERE  (AuxiliaryCode = ''	AND  AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS NOT IN (SELECT TBGrouping FROM #TBGrouping1));

UPDATE TBDetail 	SET IsMx = 0 	WHERE   (AuxiliaryCode = ''  AND (AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS IN (SELECT TBGrouping FROM #TBGrouping2)));

UPDATE TBDetail 	SET IsMx = 1 	WHERE   (AuxiliaryCode <> '' OR (AccountCode COLLATE Chinese_PRC_CS_AS_KS_WS NOT IN (SELECT TBGrouping FROM #TBGrouping2)));



--UpdateTBfsandTBaccbyTBGrouping 