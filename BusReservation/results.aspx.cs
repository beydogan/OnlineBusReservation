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
    public partial class Results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Search Results - " + ConfigurationSettings.AppSettings["siteName"].ToString();
            if (Session["do_search"] != "1")
            {
                Response.Redirect("default.aspx");
            }
            else
            {
                if (Session["is_loggedin"] != "1")
                {
                    Session["error_msg"] = "You Must Login First!";
                    Response.Redirect("login.aspx");
                }
                else
                {
                    DoSearch();
                }
            }
        }

        protected void DoSearch()
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
            String from_city = Session["search_from_city"].ToString();
            String to_city = Session["search_to_city"].ToString();
            String date = Session["search_date"].ToString();
            if (date == "")
            {
                Session["error_msg"] = "Date must be filled!";
                Response.Redirect("default.aspx");
                return;
            }
            String formatted_date = DateTime.Parse(date).ToString("MM-dd-yyyy");
          
            SqlCommand cmd = new SqlCommand("SELECT route_id, departure_time, fare, from_city, to_city, T.city_name AS to_city_name, F.city_name AS from_city_name FROM Routes INNER JOIN Cities AS T ON Routes.to_city = T.city_id INNER JOIN Cities AS F ON Routes.from_city = F.city_id WHERE from_city = '" + from_city + "' AND to_city = '" + to_city + "' AND departure_time BETWEEN CONVERT(datetime, '" + formatted_date + " 00:00:00') AND DATEADD(DAY, 1, CONVERT(datetime, '" + formatted_date + " 00:00:00')) ORDER BY departure_time ASC", con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);
            RouteGrid.DataSource = tablo.DefaultView;
            if (tablo.Rows.Count != 0)
            {
                String to_city_name = tablo.Rows[0]["to_city_name"].ToString();
                String from_city_name = tablo.Rows[0]["from_city_name"].ToString();
                result_title.Text = "Results for: " + from_city_name + " - " + to_city_name;
            }
            else
            {
                Session["error_msg"] = "No Routes Found!";
                Response.Redirect("default.aspx");
            }
            RouteGrid.DataBind();
            dr.Close();
            con.Close();
        }

        protected void RouteGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Reservation")
            {
                String route_id = e.CommandArgument.ToString();
                Session["make_reservation"] = "1";
                Session["reservation_route_id"] = route_id;
                Response.Redirect("reservation.aspx");
            }
        }

    }
}