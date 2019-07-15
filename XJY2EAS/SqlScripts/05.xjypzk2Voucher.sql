 
declare  @AccountInfo varchar(1000)  ='AccountInfo_' ,@jzpzname varchar(max),@cCount int =0,@dSql varchar(max),@expzkName varchar(1000)
declare  @ix_ppzh_index varchar(100)='ix_ppzh_'+replace(cast(newid() as varchar(50)),'-','');   



--begin 处理voucher表数据   
truncate table EAS_Voucher

insert EAS_Voucher ([date],Pzh,djh,accountcode,zy,jfje,dfje,jfsl,dfsl,zdr,FDetailID,DFKM)  
select pzrq,pzh,fjzs,kmdm,zy,  
case when jd='借' then rmb else 0 end as jfje,  
case when jd='贷' then rmb else 0 end as dfje,  
case when jd='借' then sl  else 0 end as jfsl,  
case when jd='贷' then sl  else 0 end as dfsl,  
sr,  FDetailID,DFKM  from jzpz 
  

IF OBJECT_ID('tempdb..#Expzk') IS NOT  NULL  
	DROP TABLE #Expzk  
select Pzk_TableName INTO #Expzk   from pzk where Pzk_TableName!='jzpz' and Pzk_TableName like 'jzpz%'  
alter table #Expzk add ID int IDENTITY(1,1)		
  
 select @cCount= count(1) from #Expzk
 declare @cIndex int =0;
while  (@cCount>0)begin  
	set @cIndex=@cIndex+1
    select  @expzkName =Pzk_TableName from  #Expzk where ID =@cIndex

	set @dSql ='
   insert EAS_Voucher ([date],Pzh,djh,accountcode,zy,jfje,dfje,jfsl,dfsl,zdr,FDetailID,DFKM)  
   select pzrq,pzh,fjzs,kmdm,zy,  
   case when jd=''借'' then rmb else 0 end as jfje,  
   case when jd=''贷'' then rmb else 0 end as dfje,  
   case when jd=''借'' then sl  else 0 end as jfsl,  
   case when jd=''贷'' then sl  else 0 end as dfsl,  
   sr,  
   FDetailID,DFKM from ' + @expzkName 

   exec(@dSql)
   
 SET @cCount =@cCount-1
end  
 
  
--end  
declare @year varchar(4)  
select top 1 @year=kjdate from kjqj  
  
if @year is null  
 return;  
  
 
  
 --update  '+@voucher+' set [date]=dbo.ConvertWordAngle([date],0)  
  
 update  EAS_Voucher set [date]=  
 case   
   --when len(date)=6 and cast(replace(right([date],2),space(1),0) as int)>00 then cast('''+@year+'''+''-''+replace(SUBSTRING([DATE],3,2),space(1),0)+''-''+replace(right([date],2),space(1),0) as char(10))  
   when len(date)=6 then cast(@year+'-'+replace(SUBSTRING([DATE],3,2),space(1),0)+'-'+replace(right([date],2),space(1),0) as char(10))  
   when len(date)=5 then cast(@year+'-'+replace(SUBSTRING([DATE],2,2),space(1),0)+'-'+replace(right([date],2),space(1),0) as char(10))  
  else null end  
   
 update  EAS_Voucher set Period=month([date])  

 alter table EAS_Voucher  drop column IncNo;  
 alter table EAS_Voucher  add  IncNo int;  
   

IF OBJECT_ID('tempdb..#vouchergroup') IS NOT  NULL  
	DROP TABLE #vouchergroup  
 --计算好incno  
 select ROW_NUMBER() OVER (ORDER BY period) AS RowNumber,  
 period,pzh INTO #vouchergroup from  EAS_Voucher
 group by period,pzh  
 having  COUNT(period)>1 AND count(pzh)>1  
  
 create index ix_pp_t on #vouchergroup (period,pzh)  
   
   set @dSql=' create index '+@ix_ppzh_index+' on EAS_Voucher(period,pzh)  '
   exec(@dSql)
  
 update  v set v.IncNo=vg.RowNumber  
 from  EAS_Voucher  v
 , #vouchergroup vg  
 where v.period=vg.period and v.pzh=vg.pzh;  
  
 update  EAS_Voucher 
 set zy=replace(zy,char(9),space(0))  
 where charindex(char(9),zy,0)>0  
  
 