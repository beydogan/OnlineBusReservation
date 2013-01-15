using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Data.SqlClient;

namespace BusReservation
{
    public class DBClass
    {
        string connectionstring;

        public DBClass()
        {
            connectionstring = ConfigurationManager.ConnectionStrings["conStr"].ToString();
        }

        public DataSet SelectCommand(string sqlstr)
        {
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            
            try
            {
                con.Open();
            }
            catch (Exception)
            {
                con.Close();
                throw;
            }

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(sqlstr, connectionString);
            da.Fill(ds);
            return ds;
        }

        public void ExecuteCommand(string sqlstr)
        {
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);

            try
            {
                con.Open();
            }
            catch (Exception)
            {
                con.Close();
                throw;
            }

            try
            {
                SqlCommand command = new SqlCommand(sqlstr, con);
                command.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception)
            {
                con.Close();
                throw;
            }
        }

    }
}
