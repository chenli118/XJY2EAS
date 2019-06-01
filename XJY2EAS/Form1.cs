
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
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
            var files = Un001File(filepath);
            //过滤需要导入的db文件
            #region 001ToDb
            var dbFiles = files.Where(p => Importfiles.Exists(s =>
                s == Path.GetFileNameWithoutExtension(p).ToLower()
                || (Path.GetFileNameWithoutExtension(p).ToLower() != "jzpz" &&
                    Path.GetFileNameWithoutExtension(p).ToLower().IndexOf("jzpz") > -1)));
            string acountInfo= GetAccountInfo(files.Where(x =>
                    Path.GetFileName(x).ToLower() == "ztsjbf.ini").FirstOrDefault());

            InitDataBase(acountInfo);

            Array.ForEach(dbFiles.ToArray(), (string dbfile) =>
            {
                if (importType == 0)
                {
                    // importTxtTable(dbfile);
                }
                //else if (importType != 0 &&
                //         tables.Count(x => dbfile.ToLower().IndexOf(x) > -1) > 0)
                //{
                //    importTxtTable(dbname, dbfile);
                //}
            });

            #endregion

            MessageBox.Show("导数完成！");
        }

        private void InitDataBase(string dbName)
        {
            string conStr = ConfigurationManager.AppSettings["ConString"];
            SqlMapperUtil.GetOpenConnection(conStr);
            string exsitsDB = "select count(1) from sys.sysdatabases where name =@dbName";
            int result = SqlMapperUtil.SqlWithParamsSingle<int>(exsitsDB,new { dbName = dbName });
             
            if (result ==0)
            {
                string s1 = " create database "+dbName;
                int ret = SqlMapperUtil.InsertUpdateOrDeleteSql(s1, null);
                string s2 = "CREATE TABLE dbo.kjqj    (      ProjectID VARCHAR(100) NOT NULL    , KJDate    VARCHAR(4) NOT NULL    , CONSTRAINT PK_KJQJ PRIMARY KEY(ProjectID, KJDate)    )";
                conStr = conStr.Replace("master",dbName);
                SqlMapperUtil.GetOpenConnection(conStr);
                ret = SqlMapperUtil.InsertUpdateOrDeleteSql(s2, null);
                string s3 = "CREATE TABLE dbo.kjqj    (      ProjectID VARCHAR(100) NOT NULL    , KJDate    VARCHAR(4) NOT NULL    , CONSTRAINT PK_KJQJ PRIMARY KEY(ProjectID, KJDate)    )";               
                ret = SqlMapperUtil.InsertUpdateOrDeleteSql(s3, null);



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
                //导入kjqj
                string kjqjInsert = "delete dbo.kjqj where Projectid='{0}'   insert  dbo.kjqj   select '{0}','{1}'";
                //this.DataAccess.ExecuteSql(string.Format(kjqjInsert, this.accoutNumber, accYear));
            }
        }
    }
}
