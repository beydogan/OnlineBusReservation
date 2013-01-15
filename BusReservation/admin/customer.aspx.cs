using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
namespace BusReservation.admin
{
    public partial class customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Customer List - " + ConfigurationSettings.AppSettings["siteName"].ToString();
            if (!IsPostBack)
            {
                Load_Grid();
            }
        }

        protected void Load_Grid()
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
                return;
                throw;
            }

            SqlCommand cmd = new SqlCommand("SELECT C.*, A.agent_name FROM Customers AS C INNER JOIN Users AS U ON C.user_id = U.user_id INNER JOIN Employees AS E ON E.user_id = U.user_id INNER JOIN Agents AS A ON A.agent_id = E.agent_id", con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);

            CustomerGrid.DataSource = tablo.DefaultView;
            CustomerGrid.DataBind();

            dr.Close();
            con.Close();
        }

       

       
    }

}