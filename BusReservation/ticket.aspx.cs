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
    public partial class Ticket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Show Ticket - " + ConfigurationSettings.AppSettings["siteName"].ToString();
            if (Request.QueryString["ticket_id"] == null || Session["user_id"] == null)
            {
                Response.Redirect("default.aspx");
            }
            if (!IsPostBack)
            {
                GetTicket();
            }
        }

        protected void GetTicket()
        {
            String ticket_id = Request.QueryString["ticket_id"].ToString();
            
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);

            con.Open();
            SqlCommand cmd = new SqlCommand("getTicketInfo", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TicketId", ticket_id);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);

            if (tablo.Rows[0]["user_id"].ToString() == Session["user_id"].ToString())
            {
                TicketGrid.DataSource = tablo.DefaultView;
                TicketGrid.DataBind();
            }
            else
            {
                TicketGrid.Visible = false;
            }
            dr.Close();
            con.Close();
        }

    }
}