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
    public partial class Reservation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Route List - " + ConfigurationSettings.AppSettings["siteName"].ToString();

            if (!IsPostBack)
            {
                GetReservations();
            }
        }

        protected void GetReservations()
        {
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();
            con.Open();

            if (Request.QueryString["agent_id"] == null)
            {
                cmd = new SqlCommand("SELECT * FROM ReservationView", con);
            }
            else
            {
                String agent_id = Request.QueryString["agent_id"].ToString();
                cmd = new SqlCommand("getAgentSales", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@AgentID", agent_id);
            }
            
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);

            ReservationGrid.DataSource = tablo.DefaultView;
            ReservationGrid.DataBind();
            dr.Close();
            con.Close();
        }

        protected void SearchRange_Click(object sender, EventArgs e)
        {
            String from_date = ((TextBox)rangeFrom).Text;
            String to_date = ((TextBox)rangeTo).Text;
            GetReservationsByRange(from_date, to_date);
        }

        protected void GetReservationsByRange(String from, String to)
        {
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();
            con.Open();

            cmd = new SqlCommand("SELECT DISTINCT Res.ticket_id, Res.seat_number, Res.status ,C.first_name, C.last_name, C.phone_number, Res.date AS reservation_date, R.departure_time, T.city_name AS to_city_name, F.city_name AS from_city_name, Res.user_id FROM Reservations AS Res, (Routes AS R INNER JOIN Cities AS T ON R.to_city = T.city_id INNER JOIN Cities AS F ON R.from_city = F.city_id), Users AS U, Employees AS E, Customers AS C WHERE Res.route_id = R.route_id AND Res.user_id = U.user_id AND Res.customer_id = C.customer_id AND Res.date BETWEEN CONVERT(datetime, '" + DateTime.Parse(from).ToString("MM-dd-yyyy") + " 00:00:00') AND CONVERT(datetime, '" + DateTime.Parse(to).ToString("MM-dd-yyyy") + " 00:00:00')", con);
         
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);

            ReservationGrid.DataSource = tablo.DefaultView;
            ReservationGrid.DataBind();
            dr.Close();
            con.Close();
        }

        
    }

}