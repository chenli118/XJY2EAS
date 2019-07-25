
IF object_id('tempdb..#typcode')  IS NOT NULL DROP TABLE #typcode

SELECT a.projectid,a.accountcode,case when charindex(';',a.typecode)>0 then substring(a.TypeCode,0,charindex(';',a.typecode)) else a.TypeCode end TypeCode,b.FSCode,b.kmsx,b.Yefx,b.Tbtype
 INTO #typcode 
 FROM ACCOUNT a
 INNER JOIN  TBDetail b
 ON a.ProjectID=b.ProjectID
 AND a.AccountCode=b.AccountCode
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


 


insert dbo.TBDetail(ID,ProjectID,FSCode,AccountCode, AuxiliaryCode, AccAuxName, 		DataType, TBGrouping, TBType, IsMx, IsAccMx, IsAux, kmsx, Yefx, Sqqmye, jfje, dfje,SourceFSCode)  

 select newid(), ProjectID,FSCode,AccountCode, AuxiliaryCode, AccAuxName, 		0 as DataType, AccountCode, TBType, 1, 0, 1, kmsx, Yefx, Sqqmye, jfje, dfje,'' 

			from   #aux t1 where not exists(select 1 from dbo.TBDetail o where   o.AccountCode = t1.AccountCode and o.AuxiliaryCode = t1.AuxiliaryCode and o.FSCode = t1.FSCode)  

update a set a.ismx=1 	from	 TBDetail a	inner join #typcode b		on   a.accountcode=b.accountcode and a.datatype=0

exec UpdateVoucherProjectCode @ProjectID,'',0 


