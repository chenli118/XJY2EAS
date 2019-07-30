
using Dapper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace XJY2EAS
{
    public partial class Form1 : Form
    {
        private string auditYear = "";
        private string projectid = "";
        private string accoutNumber = "";
        private string clientID = "";       
        private string dbName = "";
        string conStr = ConfigurationManager.AppSettings["ConString"];
        private List<string> Importfiles = new List<string>();
        public Form1()
        {
            InitializeComponent();
            string[] xjytables = { "km", "kmye", "xm", "xmye", "bm", "bmye", "wl", "wlye", "t_fzye", "t_itemclass", "t_itemdetail", "jzpz", "pzk" };
            Importfiles.AddRange(xjytables);
            Point point = new Point(100, 300);
            //var v = c1RadialMenu1.Visible;
            //var b= c1RadialMenu1.Expanded;
           // c1RadialMenu1.HideMenu();
           // c1RadialMenu1.UseAnimation = true;
            //c1RadialMenu1.InitializeLifetimeService();
            //this.Controls.Add();
            //var a = c1RadialMenu1.Container;
           // c1RadialMenu1.CenterOnScreen =  this.PointToClient(point);
           // c1RadialMenu1.ShowMenu(this,point,false);

        }
        string thirdDataFiles = string.Empty;
        //选择文件
        private void Button6_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.Filter = "新纪元采集文件|*.001";
                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    try
                    {
                        string doubleZeroFile = openFileDialog.FileName;
                        File.SetAttributes(doubleZeroFile, FileAttributes.Normal);
                        thirdDataFiles = doubleZeroFile.Replace(".001", "");
                        if (Directory.Exists(thirdDataFiles)) Directory.Move(thirdDataFiles, thirdDataFiles + new System.Random(100));
                        Directory.CreateDirectory(thirdDataFiles);
                        var files = Un001File(doubleZeroFile, thirdDataFiles);
                    }
                    catch (Exception ex)
                    {
                        thirdDataFiles = string.Empty;
                        MessageBox.Show(ex.Message);

                    }

                }
            }
        }
        /// <summary>
        /// 一键导入
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Button4_Click(object sender, EventArgs e)
        {
            DBInit(thirdDataFiles);
            dbName = GetDBNmame();
            conStr = conStr.Replace("master", dbName);
            InitProject(conStr);
            InitAccount(conStr);
            InitVoucher(conStr);
            InitTBFS(conStr);
            InitTbDetail(conStr);
            InitFdetail(conStr);
            InitTBAux(conStr);
            UpdateTBDetailAndTBAux(conStr);
        }
        private void DBInit(string thirdDataFiles)
        {
            if (thirdDataFiles.Length == 0) { MessageBox.Show("请选择采集后的数据文件!"); return; }
            string[] files = System.IO.Directory.GetFiles(thirdDataFiles);
            //过滤需要导入的db文件
            #region 001ToDb
            var dbFiles = files.Where(p => Importfiles.Exists(s =>
                s == Path.GetFileNameWithoutExtension(p).ToLower()
                || (Path.GetFileNameWithoutExtension(p).ToLower() != "jzpz" &&
                    Path.GetFileNameWithoutExtension(p).ToLower().IndexOf("jzpz") > -1)));
            dbName = GetAccountInfo(files.Where(x =>
                    Path.GetFileName(x).ToLower() == "ztsjbf.ini").FirstOrDefault());
            if (dbName.Length == 0)
            {
                MessageBox.Show("没找到项目信息文件");
                return;
            }
            InitDataBase(dbName);

            Array.ForEach(dbFiles.ToArray(), (string dbfile) =>
            {
                PD2SqlDB(dbfile, dbName);

                //else if (importType != 0 &&
                //         tables.Count(x => dbfile.ToLower().IndexOf(x) > -1) > 0)
                //{
                //    importTxtTable(dbname, dbfile);
                //}
            });

            #endregion

            MessageBox.Show("数据库创建完成！");
        }
        private string[] Un001File(string filepath,string targetDirectory)
        {
            try
            {
              
                using (var stream = new FileStream(filepath, FileMode.Open,
                             FileAccess.Read, FileShare.ReadWrite))
                {
                    UnZip001File.Un001File(stream, targetDirectory);

                    //获取所有文件添加到
                    var files = Directory.GetFiles(targetDirectory, "*.*",
                        SearchOption.AllDirectories).Where(s => s != null && (s.EndsWith(".db")
                            || s.EndsWith(".ini"))).ToArray();

                    return files;
                }

            }
            catch (Exception ex)
            { throw new Exception("解压001文件错误:" + ex.Message, ex); }
        }
        
       

        private async void PD2SqlDB(string filepath,String dbName)
        {

            string filename = Path.GetFileNameWithoutExtension(filepath);           
            conStr = conStr.Replace("master", dbName);
            try
            {
                var _ParadoxTable = new ParadoxReader.ParadoxTable(Path.GetDirectoryName(filepath), filename);
                var columns = _ParadoxTable.FieldNames;
                var fieldtypes = _ParadoxTable.FieldTypes;
                DataTable dt = new DataTable();
                dt.TableName = Path.GetFileNameWithoutExtension(filepath);//_ParadoxTable.TableName;
                if (columns.Length == 0 || _ParadoxTable.RecordCount == 0)
                    return;
                StringBuilder strSpt =
                    new StringBuilder(string.Format("IF object_id('{0}') IS NOT NULL  drop table  {1}", dt.TableName, dt.TableName));
                strSpt.AppendLine(" create    table   " + dt.TableName + "(" + Environment.NewLine); 
                //strSpt.AppendLine("PID " + "varchar(1000)  COLLATE Chinese_PRC_CS_AS_KS_WS  null,");
                for (int i = 0; i < columns.Length; i++)
                {
                    string fieldName = columns[i];
                    DataColumn dc = new DataColumn(fieldName);
                    ParadoxReader.ParadoxFieldTypes fieldType = fieldtypes[i].fType;
                    switch (fieldType)
                    {
                        case ParadoxReader.ParadoxFieldTypes.BCD:
                        case ParadoxReader.ParadoxFieldTypes.Number:
                        case ParadoxReader.ParadoxFieldTypes.Currency:
                        case ParadoxReader.ParadoxFieldTypes.Logical:
                        case ParadoxReader.ParadoxFieldTypes.Short:
                            strSpt.AppendLine(fieldName + " " + "decimal(19,3) null DEFAULT 0,");
                            dc.DataType = typeof(System.Decimal);
                            break;
                        default:
                            strSpt.AppendLine(fieldName + " " + "nvarchar(1000),");
                            dc.DataType = typeof(System.String);
                            break;
                    }
                    dt.Columns.Add(dc);
                }

                strSpt.AppendLine(")");
                string createDTSql = strSpt.ToString();
                if (!string.IsNullOrEmpty(createDTSql))
                {
                    SqlMapperUtil.InsertUpdateOrDeleteSql(createDTSql, null,conStr);
                }
                foreach (var rec in _ParadoxTable.Enumerate())
                {
                    DataRow dr = dt.NewRow();
                    for (int i = 0; i < _ParadoxTable.FieldCount; i++)
                    {
                        object OV = rec.DataValues[i];
                        if (!DBNull.Value.Equals(OV) && OV != null)
                            dr[_ParadoxTable.FieldNames[i]] = OV;
                    }
                    dt.Rows.Add(dr);
                }

                _ParadoxTable.Dispose();
                _ParadoxTable = null;

                SqlServerHelper.SqlBulkCopy(dt, conStr);
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("转换数据失败", filename), ex);
            }
        }
        private void InitDataBase(string dbName)
        {
            conStr = ConfigurationManager.AppSettings["ConString"];
            SqlMapperUtil.GetOpenConnection(conStr);
            string exsitsDB = "select count(1) from sys.sysdatabases where name =@dbName";
            int result = SqlMapperUtil.SqlWithParamsSingle<int>(exsitsDB,new { dbName = dbName });
             
            if (result ==0)
            {
                string s1 = " create database ["+dbName+"]";
                int ret = SqlMapperUtil.InsertUpdateOrDeleteSql(s1, null); 

            }
            conStr = conStr.Replace("master", dbName);
            SqlServerHelper.ExcuteSql(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\00.EAS_FnAndTables.Sql")), conStr);
            SqlServerHelper.ExcuteSql(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\01.Create6BasicTables.Sql")), conStr);
           
            string kjqjInsert = "delete dbo.kjqj where Projectid='{0}'  " +
                " insert  dbo.kjqj(ProjectID,CustomerCode,CustomerName,BeginDate,EndDate,KJDate)" +
                "  select '{0}','{1}','{1}','{2}','{3}','{4}'";
            SqlServerHelper.ExcuteSql(string.Format(kjqjInsert, dbName,clientID,DateTime.Parse(auditYear+"-01-01"), DateTime.Parse(auditYear + "-12-31"), auditYear), conStr);
            SqlServerHelper.ExcuteSql(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\070.AccountClass.sql")), conStr);
            SqlServerHelper.ExcuteSql(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\PackConfigTable.sql")), conStr);

        }
        private string GetDBNmame()
        {
            if (dbName.Length == 0)
            {
                DirectoryInfo di = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory);
                var accountinfofile = di.Parent.GetFiles("*.ini", SearchOption.AllDirectories)[0];
                dbName = GetAccountInfo(accountinfofile.FullName);
                if (dbName.Length == 0)
                {
                    MessageBox.Show("没找到项目信息文件");
                    return string.Empty;
                }
            }
            return dbName;
        }
        private string GetPeriod(string conStr)
        {
            string qStr = "select  MAX(pz_date) from jzpz";
            DateTime p = SqlMapperUtil.SqlWithParamsSingle<DateTime>(qStr, null, conStr);
            return p.ToShortDateString();
        }

        private string  GetAccountInfo(string filepath)
        {
            if (!File.Exists(filepath))
                MessageBox.Show("ztsjbf.ini 文件不存在!");

            using (System.IO.StreamReader sr =
                   new System.IO.StreamReader(filepath, UnicodeEncoding.GetEncoding("GBK")))
            {
                var accYear = "";
                string str = "";
                while ((str = sr.ReadLine()) != null)
                {
                    string[] arr = str.Split('=');
                    if (arr[0] == "帐套年度")
                        auditYear = accYear = arr[1];
                    if (arr[0] == "帐套编号")
                        accoutNumber = arr[1];
                    if (arr[0] == "帐套名称")
                        clientID = arr[1];
                }
                byte[] asciiBytes = Encoding.ASCII.GetBytes(accoutNumber);
                StringBuilder sb = new StringBuilder();
                Array.ForEach(asciiBytes, (c) =>
                {
                    if ((c > 47 && c < 58)
                    || (c > 64 && c < 91)
                    || (c > 96 && c < 123))
                    { sb.Append((char)c); }
                });

                return sb.ToString();
          
            }
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            DBInit(thirdDataFiles);
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            CreateMidTables();
            MessageBox.Show("转换中间表创建成功!");
        }
      
        private void CreateMidTables()
        {
            GetDBNmame();
            conStr = conStr.Replace("master", dbName);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\02.xjyxm2easproject.Sql")), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\03.t_itemclass2projecttype.Sql")), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\04.xjykmxmye2account.Sql")), null, conStr);
            
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\05.xjypzk2Voucher.Sql")).Replace("AccountInfo_",dbName), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\06.xjyItemDetail2FDetailandAux.Sql")).Replace("_EAS_", dbName), null, conStr);
            //AutomaticProcessingForUpdateProject  ProcessKmdm_jdToKmdm   

        }

        private void Button3_Click(object sender, EventArgs e)
        {
            dbName =GetDBNmame();
          
            conStr = conStr.Replace("master", dbName);
            string period = GetPeriod(conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\07.Convet_voucher_account_project.sql")).Replace("_EAS_", dbName), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\08.Update_syjz_fllx.sql")).Replace("_EAS_", dbName), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\09.init_tbdetail.sql")).Replace("_EAS_", dbName), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\10.UpdateProject4tbvoucher.sql")).Replace("_EAS_", dbName), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\11.InitTBAux.sql")).Replace("_EAS_", dbName), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\12.Updatedfjfje_tbdetail_tbaux.sql")).Replace("_EAS_", dbName), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\13.UpdateTbQqccgz.sql")).Replace("_EAS_", dbName), null, conStr);

            //var p = new DynamicParameters();
            //p.Add("@ProjectID", dbName);   
            //SqlMapperUtil.InsertUpdateOrDeleteStoredProc("ByFllxUpdateTbAccAndTbAuxQqccgz", p, conStr);
            MessageBox.Show("导入成功！");
        }

      
        private void C1Command1_Click(object sender, C1.Win.C1Command.ClickEventArgs e)
        {
          

        }

        private void UpdateTBDetailAndTBAux(string conStr)
        {
            string pzdate= GetPeriod(conStr);
            var p = new DynamicParameters();
            p.Add("@pzEndDate", pzdate);   
            SqlMapperUtil.InsertUpdateOrDeleteStoredProc("UpdateTBDetailTBAuxJE", p, conStr);
            MessageBox.Show("UpdateTBDetailTBAuxJE 完成！");
        }

        private void InitTBFS(string conStr)
        {
            string execSQL = "Insert TBFS  SELECT * FROM Pack_TBFS  where projectid='audCas'";
            SqlMapperUtil.CMDExcute(execSQL, null, conStr);
        }

        private void InitTBAux(string conStr)
        {
            DataTable auxTable = new DataTable();
            auxTable.TableName = "TBAux";
            auxTable.Columns.Add("ProjectID");
            auxTable.Columns.Add("AccountCode");
            auxTable.Columns.Add("AuxiliaryCode");
            auxTable.Columns.Add("AuxiliaryName");
            auxTable.Columns.Add("FSCode");
            auxTable.Columns.Add("kmsx");
            auxTable.Columns.Add("YEFX", typeof(int));
            auxTable.Columns.Add("TBGrouping");
            auxTable.Columns.Add("Sqqmye", typeof(decimal));
            auxTable.Columns.Add("Qqccgz", typeof(decimal));
            auxTable.Columns.Add("jfje", typeof(decimal));
            auxTable.Columns.Add("dfje", typeof(decimal));
            auxTable.Columns.Add("qmye", typeof(decimal));
            string qsql = "select distinct idet.accountcode,idet.AuxiliaryCode, isnull(xm.xmmc,space(0)) as AuxiliaryName,xmye.ncye as Sqqmye  from AuxiliaryFDetail idet join  xm xm   on LTRIM(rtrim(xm.xmdm)) COLLATE Chinese_PRC_CS_AS_KS_WS=idet.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS      join xmye xmye on idet.accountcode COLLATE Chinese_PRC_CS_AS_KS_WS = ltrim(rtrim(xmye.kmdm)) COLLATE Chinese_PRC_CS_AS_KS_WS and idet.AuxiliaryCode COLLATE Chinese_PRC_CS_AS_KS_WS = LTRIM(rtrim(xmye.xmdm)) COLLATE Chinese_PRC_CS_AS_KS_WS  ";
            dynamic ds = SqlMapperUtil.SqlWithParams<dynamic>(qsql, null, conStr);
            foreach (var vd in ds)
            {
                DataRow dr = auxTable.NewRow();
                dr["ProjectID"] = dbName;
                dr["AccountCode"] = vd.accountcode;
                dr["AuxiliaryCode"] = vd.AuxiliaryCode;
                dr["AuxiliaryName"] = vd.AuxiliaryName;
                dr["FSCode"] = string.Empty;
                dr["kmsx"] = 0;
                dr["YEFX"] = 0;
                dr["TBGrouping"] = vd.accountcode;
                dr["Sqqmye"] = vd.Sqqmye==null?0M:vd.Sqqmye;
                dr["Qqccgz"] = 0M;
                dr["jfje"] = 0M;
                dr["dfje"] = 0M;
                dr["qmye"] = 0M;
                auxTable.Rows.Add(dr);
            }
            string execSQL = " truncate table  " + auxTable.TableName;
            SqlMapperUtil.CMDExcute(execSQL, null, conStr);
            SqlServerHelper.SqlBulkCopy(auxTable, conStr);

            MessageBox.Show("TBAux初始化完成！");


        }

        /// <summary>
        /// [InitTbAccTable] [ByContinueDateUpdateTBAcc]
        /// </summary>
        /// <param name="conStr"></param>
        private void InitTbDetail(string conStr)
        {
            #region old
            /*
            DataTable dtDetail = new DataTable();
            dtDetail.TableName = "TBDetail";
            #region columns
            dtDetail.Columns.Add("ID");
            dtDetail.Columns.Add("ProjectID");
            dtDetail.Columns.Add("FSCode");
            dtDetail.Columns.Add("AccountCode");
            dtDetail.Columns.Add("AuxiliaryCode");
            dtDetail.Columns.Add("AccAuxName");
            dtDetail.Columns.Add("DataType", typeof(int));
            dtDetail.Columns.Add("TBGrouping");
            dtDetail.Columns.Add("TBType", typeof(int));
            dtDetail.Columns.Add("IsAccMx", typeof(int));
            dtDetail.Columns.Add("IsMx", typeof(int));
            dtDetail.Columns.Add("IsAux", typeof(int));
            dtDetail.Columns.Add("kmsx");
            dtDetail.Columns.Add("Yefx", typeof(int));
            dtDetail.Columns.Add("SourceFSCode");
            dtDetail.Columns.Add("Sqqmye", typeof(decimal));
            dtDetail.Columns.Add("Qqccgz", typeof(decimal));
            dtDetail.Columns.Add("jfje", typeof(decimal));
            dtDetail.Columns.Add("dfje", typeof(decimal));
            dtDetail.Columns.Add("CrjeJF", typeof(decimal));
            dtDetail.Columns.Add("CrjeDF", typeof(decimal));
            dtDetail.Columns.Add("AjeJF", typeof(decimal));
            dtDetail.Columns.Add("AjeDF", typeof(decimal));
            dtDetail.Columns.Add("RjeJF", typeof(decimal));
            dtDetail.Columns.Add("RjeDF", typeof(decimal));
            dtDetail.Columns.Add("TaxBase", typeof(decimal));
            dtDetail.Columns.Add("PY1", typeof(decimal));
            dtDetail.Columns.Add("jfje1", typeof(decimal));
            dtDetail.Columns.Add("dfje1", typeof(decimal));
            dtDetail.Columns.Add("jfje2", typeof(decimal));
            dtDetail.Columns.Add("dfje2", typeof(decimal));
            #endregion
            string qsql = "select distinct NEWID() ID ,a.AccountCode,space(0) AS SourceFSCode," +
                " a.AccountName as AccAuxName,a.jb as TBType,0 AS IsMx, a.UpperCode TBGrouping, a.Ncye AS Sqqmye,space(0) fscode,1 yefx,0 kmsx," +
                "0 AS isAux,a.ismx AS isAccMx,0 AS DataType,Qqccgz,Hsxms,TypeCode from dbo.Account a with(nolock)   ";

            dynamic ds = SqlMapperUtil.SqlWithParams<dynamic>(qsql, null, conStr);
            foreach (var vd in ds)
            {
                DataRow dr = dtDetail.NewRow();
                dr["ID"] = vd.ID;
                dr["ProjectID"]=dbName;
                dr["FSCode"] = vd.fscode;
                dr["AccountCode"] = vd.AccountCode;
                dr["AuxiliaryCode"] = vd.TypeCode;
                dr["AccAuxName"] = vd.AccAuxName;
                dr["DataType"] = vd.DataType;
                dr["TBGrouping"] = vd.TBGrouping;
                dr["TBType"] = vd.TBType;
                dr["IsAccMx"] = vd.isAccMx;
                dr["IsMx"] = vd.IsMx;
                dr["IsAux"] = 0;
                dr["kmsx"] = vd.kmsx;
                dr["Yefx"] = vd.yefx;
                dr["SourceFSCode"] = vd.SourceFSCode;
                dr["Sqqmye"] = vd.Sqqmye==null?0M:vd.Sqqmye;
                dr["Qqccgz"] = vd.Qqccgz;
                dr["jfje"] = 0M;
                dr["dfje"] = 0M;
                dr["CrjeJF"] = 0M;
                dr["CrjeDF"] = 0M;
                dr["AjeJF"] = 0M;
                dr["AjeDF"] = 0M;
                dr["RjeJF"] = 0M;
                dr["RjeDF"] = 0M;
                dr["TaxBase"] = 0M;
                dr["PY1"] = 0M;
                dr["jfje1"] = 0M;
                dr["dfje1"] = 0M;
                dr["jfje2"] = 0M;
                dr["dfje2"] = 0M;
                dtDetail.Rows.Add(dr);

            }
            string execSQL = " truncate table  " + dtDetail.TableName;
            SqlMapperUtil.CMDExcute(execSQL, null, conStr);
            SqlServerHelper.SqlBulkCopy(dtDetail, conStr); */
            #endregion 
            var p = new DynamicParameters();
            p.Add("@ProjectID", dbName);
            SqlMapperUtil.InsertUpdateOrDeleteStoredProc("InitTbAccTable", p, conStr);
            MessageBox.Show("TBDetail初始化完成！");
        }

        private void InitFdetail(string conStr)
        {
            DataTable auxfdetail = new DataTable();
            auxfdetail.TableName = "AuxiliaryFDetail";
            auxfdetail.Columns.Add("projectid");
            auxfdetail.Columns.Add("Accountcode");
            auxfdetail.Columns.Add("AuxiliaryCode");
            auxfdetail.Columns.Add("Ncye", typeof(decimal));
            auxfdetail.Columns.Add("Jfje1", typeof(decimal));
            auxfdetail.Columns.Add("Dfje1", typeof(decimal));
            auxfdetail.Columns.Add("FDetailID", typeof(int));
            auxfdetail.Columns.Add("DataType", typeof(int));
            auxfdetail.Columns.Add("DataYear", typeof(int)); 

            string itemclass = "select * from t_itemclass";
            var tab_ic = SqlMapperUtil.SqlWithParams<dynamic>(itemclass, null, conStr);
            List<string> xmField = new List<string>();
            foreach (var iid in tab_ic)
            {
                xmField.Add("F" + iid.FItemClassID);
            }
            string sql1 = "select  * from t_itemdetail  t join t_fzye f on t.FDetailID = f.FDetailID  ";
            var d1 = SqlMapperUtil.SqlWithParams<dynamic>(sql1, null, conStr);
            foreach (var d in d1)
            {
                Array.ForEach(xmField.ToArray(), f => {

                    foreach (var xv in d)
                    {
                        if (xv.Key == f)
                        {
                            if (!string.IsNullOrWhiteSpace(xv.Value))
                            {
                                DataRow dr1 = auxfdetail.NewRow();
                                dr1["projectid"] = dbName;
                                dr1["Accountcode"] = d.Kmdm;
                                dr1["AuxiliaryCode"] = xv.Value;                              
                                dr1["Ncye"] = d.Ncye;
                                dr1["Jfje1"] = d.Jfje1;
                                dr1["Dfje1"] = d.Dfje1;
                                dr1["FDetailID"] = d.FDetailID;
                                dr1["DataType"] =0;
                                dr1["DataYear"] = int.Parse(auditYear);
                                auxfdetail.Rows.Add(dr1);
                            }
                        }
                    }

                });
            }
            string execSQL = " truncate table  "+ auxfdetail.TableName;
            SqlMapperUtil.CMDExcute(execSQL, null, conStr);
            SqlServerHelper.SqlBulkCopy(auxfdetail, conStr);
            //string conStr2 = "server = 192.168.1.33; uid = sa; pwd = sa; database = Szmz; Max Pool Size=1200; ";
            //string sql2 = " Select * from AuxiliaryFDetail where ProjectID = 'AudSzmz_3_201812'  ";
            //dynamic d2 = SqlMapperUtil.SqlWithParams<dynamic>(sql2, null, conStr2);
            MessageBox.Show("辅助核算对照表初始化完成！");
        }

        private void InitVoucher(string conStr)
        {
            DataTable dtVoucher = new DataTable();
            dtVoucher.TableName = "TBVoucher";
            #region columns
            dtVoucher.Columns.Add("VoucherID");
            dtVoucher.Columns.Add("Clientid");
            dtVoucher.Columns.Add("ProjectID");
            dtVoucher.Columns.Add("IncNo");
            dtVoucher.Columns.Add("Date", typeof(DateTime));
            dtVoucher.Columns.Add("Period", typeof(int));
            dtVoucher.Columns.Add("Pzlx");
            dtVoucher.Columns.Add("Pzh");
            dtVoucher.Columns.Add("Djh");
            dtVoucher.Columns.Add("AccountCode");
            dtVoucher.Columns.Add("ProjectCode");
            dtVoucher.Columns.Add("Zy");
            dtVoucher.Columns.Add("Jfje", typeof(decimal));
            dtVoucher.Columns.Add("Dfje", typeof(decimal));
            dtVoucher.Columns.Add("Jfsl", typeof(decimal));
            dtVoucher.Columns.Add("Dfsl", typeof(decimal));
            dtVoucher.Columns.Add("ZDR");
            dtVoucher.Columns.Add("dfkm");
            dtVoucher.Columns.Add("Jd", typeof(int));
            dtVoucher.Columns.Add("Fsje", typeof(decimal));
            dtVoucher.Columns.Add("Wbdm");
            dtVoucher.Columns.Add("Wbje", typeof(decimal));
            dtVoucher.Columns.Add("Hl", typeof(decimal));
            dtVoucher.Columns.Add("FLLX", typeof(int));
            dtVoucher.Columns.Add("SampleSelectedYesNo", typeof(int));
            dtVoucher.Columns.Add("SampleSelectedType", typeof(int));
            dtVoucher.Columns.Add("TBGrouping");
            dtVoucher.Columns.Add("EASREF");
            dtVoucher.Columns.Add("AccountingAge", typeof(int));
            dtVoucher.Columns.Add("qmyegc", typeof(int));
            dtVoucher.Columns.Add("Stepofsample", typeof(int));
            dtVoucher.Columns.Add("ErrorYesNo", typeof(int));
            dtVoucher.Columns.Add("FDetailID", typeof(int));
            #endregion

            string jzpzSQL = "select Pz_Date,Kjqj,pzrq,Pzh,Djh,IncNo,fjzs,Kmdm,zy, Jd,Wbdm,Wbje,Hl,case when jd = '借' then rmb else 0 end as jfje,  " +
                "case when jd = '贷' then rmb else 0 end as dfje,  " +
                "case when jd = '借' then sl  else 0 end as jfsl,  " +
                "case when jd = '贷' then sl  else 0 end as dfsl,  sr,  FDetailID,DFKM from jzpz ";
            dynamic ds = SqlMapperUtil.SqlWithParams<dynamic>(jzpzSQL, null, conStr);
            foreach (var vd in ds)
            {
                DataRow dr = dtVoucher.NewRow();
                dr["VoucherID"] = Guid.NewGuid();
                dr["Clientid"] = clientID;
                dr["ProjectID"] = dbName;
                dr["IncNo"] = vd.IncNo;
                dr["Date"] = vd.Pz_Date;
                dr["Period"] = vd.Kjqj;
                dr["Pzlx"] = "";
                dr["Pzh"] = vd.Pzh;
                dr["Djh"] = vd.Djh == null ? 0 : vd.Djh;
                dr["AccountCode"] = vd.Kmdm;
                dr["ProjectCode"] = "";
                dr["Zy"] = vd.zy;
                dr["Jfje"] = vd.jfje == null ? 0M : vd.jfje;
                dr["Dfje"] = vd.dfje == null ? 0M : vd.dfje;
                dr["Jfsl"] = vd.jfsl == null ? 0M : vd.jfsl;
                dr["Dfsl"] = vd.dfsl == null ? 0M : vd.dfsl;
                dr["ZDR"] = vd.sr;
                dr["dfkm"] = vd.DFKM;
                dr["Jd"] = vd.Jd == "借" ? 1 : -1;
                dr["Fsje"] = Convert.ToInt32(dr["Jd"]) * (Convert.ToDecimal(dr["Jfje"]) + Convert.ToDecimal(dr["Dfje"]));
                dr["Wbdm"] = vd.Wbdm == null ? 0M : vd.Wbdm;
                dr["Wbje"] = vd.Wbje == null ? 0M : vd.Wbje;
                dr["Hl"] = vd.Hl;
                dr["FLLX"] = 1;
                dr["FDetailID"] = vd.FDetailID == null ? -1 : vd.FDetailID;
                dr["SampleSelectedYesNo"] = 0M;
                dr["SampleSelectedType"] = 0M;
                dr["TBGrouping"] = "";
                dr["EASREF"] = "";
                dr["AccountingAge"] = 0M;
                dr["qmyegc"] = 0M;
                dr["Stepofsample"] = 0M;
                dr["ErrorYesNo"] = 0M;
                dtVoucher.Rows.Add(dr);

            }
             

            string execSQL = " truncate table TBVoucher ";
            SqlMapperUtil.CMDExcute(execSQL, null, conStr);
            SqlServerHelper.SqlBulkCopy(dtVoucher, conStr);
            string updatesql = " update v set v.fllx = case when a.Syjz = 0 then 1 else a.Syjz end   from dbo.tbvoucher v     join ACCOUNT a on a.AccountCode = v.AccountCode  ";
            SqlMapperUtil.CMDExcute(updatesql, null, conStr);
            MessageBox.Show("凭证表初始化完成！");
        }
 

        private void InitAccount(string conStr)
        {
            DataTable accountTable = new DataTable();
            accountTable.TableName = "ACCOUNT";
            accountTable.Columns.Add("ProjectID");
            accountTable.Columns.Add("AccountCode");
            accountTable.Columns.Add("UpperCode");
            accountTable.Columns.Add("AccountName");
            accountTable.Columns.Add("Attribute",typeof(int));
            accountTable.Columns.Add("Jd", typeof(int));
            accountTable.Columns.Add("Hsxms", typeof(int));
            accountTable.Columns.Add("TypeCode");
            accountTable.Columns.Add("Jb", typeof(int));
            accountTable.Columns.Add("IsMx", typeof(int));
            accountTable.Columns.Add("Ncye",typeof(decimal));
            accountTable.Columns.Add("Qqccgz", typeof(decimal));
            accountTable.Columns.Add("Jfje", typeof(decimal));
            accountTable.Columns.Add("Dfje", typeof(decimal));
            accountTable.Columns.Add("Ncsl", typeof(int));
            accountTable.Columns.Add("Syjz", typeof(int));
            //按级别排序
            string qsql = "SELECT km.kmdm,km.kmmc,KM_TYPE,KM_YEFX,Xmhs,Kmjb,IsMx,Ncye,Jfje1,Dfje1,Ncsl  FROM KM   left join kmye  on km.kmdm = kmye.kmdm  order by Kmjb";
            dynamic ds = SqlMapperUtil.SqlWithParams<dynamic>(qsql, null, conStr);
            foreach (var vd in ds)
            {
               DataRow dr = accountTable.NewRow();
               dr["ProjectID"] = dbName;
                dr["AccountCode"] = vd.kmdm;
                dr["UpperCode"] ="";
                dr["AccountName"] = vd.kmmc;
                dr["Attribute"] = vd.KM_TYPE == "损益" ? 1 : 0;
                dr["Jd"] = vd.KM_YEFX;
                dr["Hsxms"] = 0;
                dr["TypeCode"] = "";
                dr["Jb"] = vd.Kmjb;
                dr["IsMx"] = vd.IsMx==null?0:1;
                dr["Ncye"] = vd.Ncye == null ? 0M : vd.Ncye;
                dr["Qqccgz"] = 0M;
                dr["Jfje"] = vd.Jfje1 == null ? 0M : vd.Jfje1;
                dr["Dfje"] = vd.Dfje1 == null ? 0M : vd.Dfje1;
                dr["Ncsl"] = vd.Ncsl == null ? 0M : vd.Ncsl;
                dr["Syjz"] = 0; 
                accountTable.Rows.Add(dr);

               
            }
            BuildUpperCode(accountTable,conStr);
            BuildTypeCode(accountTable, conStr);
            string execSQL = " truncate table ACCOUNT ";
            SqlMapperUtil.CMDExcute(execSQL, null, conStr);
            SqlServerHelper.SqlBulkCopy(accountTable, conStr);
            MessageBox.Show("科目表初始化完成！");
        }

        private void BuildTypeCode(DataTable accountTable,string conStr)
        {
            string typeSql = "; with s1 as( SELECT DISTINCT _xmye.KMDM,_xmye.XMDM,icl.FITEMID as typecode FROM XMYE _xmye JOIN xm xm ON _xmye.Xmdm COLLATE Chinese_PRC_CS_AS_KS_WS = xm.Xmdm COLLATE Chinese_PRC_CS_AS_KS_WS  INNER JOIN t_itemclass icl   ON LEFT(xm.Xmdm, LEN(icl.FItemId))= icl.FItemId )   SELECT DISTINCT KMDM, typecode from s1 ;";
            dynamic ds = SqlMapperUtil.SqlWithParams<dynamic>(typeSql, null, conStr);

            Dictionary<string, List<string>> dicTypeCode = new Dictionary<string, List<string>>();
            
            foreach (var vd in ds)
            {
                if (!dicTypeCode.ContainsKey(vd.KMDM))
                {
                    List<string> list = new List<string>();
                    list.Add(vd.typecode);
                    dicTypeCode.Add(vd.KMDM, list);
                }
                else
                {
                    dicTypeCode[vd.KMDM].Add(vd.typecode);
                } 
            }
            foreach (string k in dicTypeCode.Keys)
            {
                var row = accountTable.Rows.Cast<DataRow>().Where(x => x["AccountCode"].ToString() == k).SingleOrDefault();
                if (row != null)
                {
                    row["TypeCode"] = string.Join(";",dicTypeCode[k].ToArray());
                    row["Hsxms"] = dicTypeCode[k].Count;
                }
            }
        }

        private void BuildUpperCode(DataTable accountTable ,string conStr)
        {

            string syjzSql = " select * from   Accountclass ac with(nolock) ";
            dynamic syjzdt = SqlMapperUtil.SqlWithParams<dynamic>(syjzSql, null, conStr);

            foreach (DataRow dr in accountTable.Rows)
            {
                int jb = -1;
                int.TryParse(dr["Jb"].ToString(),out jb);
                if (jb<1) continue;
                if (jb == 1)
                {
                    foreach (var s in syjzdt)
                    {
                        if (dr["AccountName"].ToString().StartsWith(s.Accountname))
                        {
                            dr["Syjz"] = s.syjz;
                        }
                    }
                    
                }
                else
                {
                    var uprow = accountTable.Rows.Cast<DataRow>().Where(x => x["Jb"].ToString() == (jb - 1).ToString()
                    && dr["AccountCode"].ToString().StartsWith(x["AccountCode"].ToString())).SingleOrDefault();
                    dr["UpperCode"] = uprow["AccountCode"];
                    dr["Syjz"] = uprow["Syjz"];
                }

            }
        }

        private void InitProject(string conStr)
        { 
            string projectsql = " truncate table PROJECT  ; INSERT  PROJECT   SELECT Distinct '" + dbName + "', LEFT(XMDM, CHARINDEX('.', XMDM)),XMDM,isnull(XMMC,space(0)),NULL,XMJB,XMMX     FROM XM " +
                " ; update PROJECT set ProjectCode=LTRIM(rtrim(ProjectCode)),TypeCode=LTRIM(rtrim(TypeCode))  ";
            SqlMapperUtil.CMDExcute(projectsql, null, conStr);
             
            string projecttypesql = " truncate table ProjectType  ; INSERT  ProjectType  SELECT   '" + dbName + "', FITEMID,FName FROM t_itemclass" +
                " ; update  PROJECTTYPE set TypeCode=LTRIM(rtrim(TypeCode))   ";
            SqlMapperUtil.CMDExcute(projecttypesql, null, conStr);

            MessageBox.Show("项目初始化完成！");
        }
        
       
 
       
    }
}
