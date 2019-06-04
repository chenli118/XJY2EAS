
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
        private string accoutNumber = "";
        private int importType = 0;
        private string dbName = "";
        string conStr = ConfigurationManager.AppSettings["ConString"];
        private List<string> Importfiles = new List<string>();
        public Form1()
        {
            InitializeComponent();
            string[] xjytables = { "km", "kmye", "xm", "xmye", "bm", "bmye", "wl", "wlye", "t_fzye", "t_itemclass", "t_itemdetail", "jzpz", "pzk" };
            Importfiles.AddRange(xjytables);


        }


        private string[] Un001File(string filepath)
        {
            try
            {
                string unZipFilePath = filepath.Replace(".001", "");
                if (!Directory.Exists(unZipFilePath)) Directory.CreateDirectory(unZipFilePath);
                using (var stream = new FileStream(filepath, FileMode.Open,
                             FileAccess.Read, FileShare.ReadWrite))
                {
                    UnZip001File.Un001File(stream, unZipFilePath);

                    //获取所有文件添加到
                    var files = Directory.GetFiles(unZipFilePath, "*.*",
                        SearchOption.AllDirectories).Where(s => s != null && (s.EndsWith(".db")
                            || s.EndsWith(".ini"))).ToArray();

                    return files;
                }

            }
            catch (Exception ex)
            { throw new Exception("解压001文件错误:" + ex.Message, ex); }
        }



        private void Button1_Click(object sender, EventArgs e)
        {
            var sourceFiles = Directory.GetFiles(AppDomain.CurrentDomain.BaseDirectory, "*.001");
            if (sourceFiles.Length == 0) { MessageBox.Show("未找到001文件!"); }
            string filepath = sourceFiles[0];
            File.SetAttributes(filepath, FileAttributes.Normal);

            //001 to pd
            var files = Un001File(filepath);
          
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
                if (importType == 0)
                {
                    PD2SqlDB(dbfile, dbName);
                }
                //else if (importType != 0 &&
                //         tables.Count(x => dbfile.ToLower().IndexOf(x) > -1) > 0)
                //{
                //    importTxtTable(dbname, dbfile);
                //}
            });

            #endregion

            MessageBox.Show("新纪元数据库创建完成！");
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
                            strSpt.AppendLine(fieldName + " " + "float null DEFAULT 0,");
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

                using (SqlConnection connection = new SqlConnection(conStr))
                {
                    using (SqlBulkCopy copy = new SqlBulkCopy(connection))
                    {
                        copy.DestinationTableName = dt.TableName;

                        foreach (DataColumn column in dt.Columns)
                        {
                            copy.ColumnMappings.Add(new SqlBulkCopyColumnMapping(column.ColumnName, column.ColumnName));
                        }

                        connection.Open();
                        copy.BulkCopyTimeout = 0;
                        await copy.WriteToServerAsync(dt);
                        connection.Close();
                    }

                }
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
                string s1 = " create database "+dbName;
                int ret = SqlMapperUtil.InsertUpdateOrDeleteSql(s1, null);
                conStr = conStr.Replace("master",dbName);  



                string kjqjInsert = "delete dbo.kjqj where Projectid='{0}'   insert  dbo.kjqj   select '{0}','{1}'";               
                SqlServerHelper.ExcuteSql(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\00.EAS_FnAndTables.Sql")),  conStr);
                SqlServerHelper.ExcuteSql(string.Format(kjqjInsert, dbName, auditYear),  conStr); 


            }
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

        private void Button2_Click(object sender, EventArgs e)
        {
            CreateMidTables();
        }

        private void CreateMidTables()
        {
            if (dbName.Length == 0)
            {
                DirectoryInfo di = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory);
                var accountinfofile = di.Parent.GetFiles("*.ini", SearchOption.AllDirectories)[0];
                dbName = GetAccountInfo(accountinfofile.FullName);
                if (dbName.Length == 0) {
                    MessageBox.Show("没找到项目信息文件");
                    return;
                }
            }
            conStr = conStr.Replace("master", dbName);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\01.Create6BasicTables.Sql")), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\02.xjyxm2easproject.Sql")), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\03.t_itemclass2projecttype.Sql")), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\04.xjykmxmye2account.Sql")), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\05.xjypzk2Voucher.Sql")), null, conStr);
            SqlMapperUtil.CMDExcute(File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScript\\06.xjyItemDetail2FDetailandAux.Sql")).Replace("EAS_", dbName), null, conStr);

        }

        private void Button3_Click(object sender, EventArgs e)
        {

        }
    }
}
