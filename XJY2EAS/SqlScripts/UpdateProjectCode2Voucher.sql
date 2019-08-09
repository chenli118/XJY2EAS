
;with a1 as(select ROW_NUMBER() OVER (ORDER BY t.accountcode) AS ID,  t.fscode,   t.projectid, t.accountcode,t.auxiliaryCode,a.DataYear,a.FDetailID    
 from dbo.TBDetail t   inner join dbo.AuxiliaryFDetail a  on  t.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=a.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS    
 and t.auxiliarycode COLLATE Chinese_PRC_CS_AS_KS_WS=a.auxiliarycode COLLATE Chinese_PRC_CS_AS_KS_WS     and a.datatype=0 where  t.datatype=0 and t.auxiliarycode!=''   )
 update v  set v.ProjectCode=a1.auxiliaryCode from dbo.TBVoucher v inner join  a1 on v.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS=a1.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS
  and v.FDetailID=a1.FDetailID    and v.ProjectID COLLATE Chinese_PRC_CS_AS_KS_WS=a1.ProjectID COLLATE Chinese_PRC_CS_AS_KS_WS    
