using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace BusReservation
{
    public partial class Agent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Show Ticket - " + ConfigurationSettings.AppSettings["siteName"].ToString();
            if (Session["user_id"] == null )
            {
                Response.Redirect("default.aspx");
            }
            if (!IsPostBack)
            {
                GetTickets();
            }
        }

        protected void GetTickets()
        {
            String user_id = Session["user_id"].ToString();
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("getEmployeeSales", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", user_id);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);

            TicketsGrid.DataSource = tablo.DefaultView;
            TicketsGrid.DataBind();
          
            dr.Close();
            con.Close();
        }

    }
}