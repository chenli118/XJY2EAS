using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace XJY2EAS
{
   internal class SqlServerHelper
    {
        public async static void SqlBulkCopy(System.Data.DataTable dt, string conStr)
        {
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
        public static int ExcuteSql(string sql, string constr)
        {
            using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(constr))
            {
                try
                {
                    if (conn.State != System.Data.ConnectionState.Open) conn.Open();
                    System.Data.SqlClient.SqlCommand sqlCommand = new System.Data.SqlClient.SqlCommand(sql, conn);
                    foreach (var sqlBatch in sql.Split(new[] { "GO" ,"go"}, StringSplitOptions.RemoveEmptyEntries))
                    {
                        sqlCommand.CommandText = sqlBatch;
                        sqlCommand.ExecuteNonQuery();
                    }
                    return 1;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
                finally{
                    conn.Close();
                    conn.Dispose();
                }

            }
        }
    }
}
