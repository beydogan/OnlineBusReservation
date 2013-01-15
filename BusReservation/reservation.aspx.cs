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
    public partial class Reservation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Make Reservation - " + ConfigurationSettings.AppSettings["siteName"].ToString();

            if (Session["make_reservation"] != "1")
            {
                Response.Redirect("default.aspx");
            }
            else
            {
                if (Session["is_loggedin"] != "1")
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        PrintSeats();
                    }
                }
            }
        }

        protected void PrintSeats()
        {
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();
            String route_id = Session["reservation_route_id"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("SELECT seat_count FROM Routes, Bus Where Routes.bus_id = bus.bus_id AND route_id = '"+ route_id+"'", con);
            routeId.Value = route_id;
            List<string> reservedSeats = GetReservedSeats(route_id);
            con.Open();
            int seatCount = (int)cmd.ExecuteScalar();
            con.Close();

            for (int i = 1; i <= seatCount; i++)
            {
                ListItem new_item = new ListItem(i.ToString(), i.ToString());
                if (reservedSeats.Contains(i.ToString()))
                {
                    new_item.Enabled = false;
                }
                seat_list1.Items.Add(new_item);
            }
            //int seat_num = 1;
            //for (int i = 1; i <= rowCount; i++)
            //{
            //    if (seatCount == 0)
            //        break;
            //    ListItem new_item = new ListItem(seat_num.ToString(), seat_num.ToString());
            //    if(reservedSeats.Contains(seat_num.ToString())){
            //        new_item.Enabled = false;
            //    }
            //    seat_list1.Items.Add(new_item);
            //    seat_num = seat_num + 4;
            //    seatCount--;
            //}
            //seat_num = 2;
            //for (int i = 1; i <= rowCount; i++)
            //{
            //    if (seatCount == 0)
            //        break;
            //    ListItem new_item = new ListItem(seat_num.ToString(), seat_num.ToString());
            //    if(reservedSeats.Contains(seat_num.ToString())){
            //        new_item.Enabled = false;
            //    }
            //    seat_list2.Items.Add(new_item);
            //    seat_num = seat_num + 4;
            //    seatCount--;
            //}
            //seat_num = 3;
            //for (int i = 1; i <= rowCount; i++)
            //{
            //    if (seatCount == 0)
            //        break;
            //    ListItem new_item = new ListItem(seat_num.ToString(), seat_num.ToString());
            //     if(reservedSeats.Contains(seat_num.ToString())){
            //        new_item.Enabled = false;
            //    }
            //    seat_list3.Items.Add(new_item);
            //    seat_num = seat_num + 4;
            //    seatCount--;
            //}
            //seat_num = 4;
            //for (int i = 1; i <= rowCount; i++)
            //{
            //    if (seatCount == 0)
            //        break;
            //    ListItem new_item = new ListItem(seat_num.ToString(), seat_num.ToString());
            //    if (reservedSeats.Contains(seat_num.ToString()))
            //    {
            //        new_item.Enabled = false;
            //    }
            //    seat_list4.Items.Add(new_item);
            //    seat_num = seat_num + 4;
            //    seatCount--;
            //}
        }

        protected List<String> GetReservedSeats(String route_id)
        {
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            SqlDataAdapter da = new SqlDataAdapter("SELECT seat_number FROM Reservations WHERE route_id = '" + route_id + "'", con);
            DataSet ds = new DataSet();
            da.Fill(ds, "seats");
            List<string> seats = new List<string>();
            foreach (DataRow row in ds.Tables["seats"].Rows)
            {
                seats.Add(row["seat_number"].ToString());
            }

            return seats;
        }

        protected void ProcessReservation(object sender, EventArgs e)
        {
            String user_id = Session["user_id"].ToString();
            String first_name = firstname.Text;
            String last_name = lastname.Text;
            String birth_date = birthdate.Text;
            String phone_number = phonenumber.Text;
            String gender_str = gender.Text;
            String email_str = email.Text;
            String seat = seat_list1.SelectedValue;
            String route_id = routeId.Value;
            if (first_name == "" || last_name == "" || birth_date == "" || phone_number == "" || gender_str == "" || email_str == "")
            {
                LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                objPanelText.Text = "<strong>Error: </strong>All fields must be filled.";
                errorPanel.Visible = true;
                return;
            }

            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("INSERT INTO Customers(first_name, last_name, phone_number, gender, birth_date, email, user_id) output inserted.customer_id VALUES ('" + first_name + "','" + last_name + "','" + phone_number + "','" + gender_str + "',CAST('" + DateTime.Parse(birth_date).ToString("yyyy-MM-dd H:mm") + "' AS DATETIME) ,'" + email_str + "','" + user_id + "')", con);
            con.Open();
            int new_customer_id = (int)cmd.ExecuteScalar();
            con.Close();
            CreateReservation(route_id, seat, new_customer_id);
        }

        protected void CreateReservation(String route_id, String seat_number, int customer_id)
        {
            String user_id = Session["user_id"].ToString();
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("INSERT INTO Reservations(user_id, route_id, customer_id, date, status, seat_number) VALUES ('" + user_id + "','" + route_id + "','" + customer_id + "',CAST('" + DateTime.Now.ToString("yyyy-MM-dd H:mm") + "' AS DATETIME) ,'1','" + seat_number + "')", con);
            con.Open();
            //int ticket_id = (int)cmd.ExecuteScalar();
            //Response.Redirect("ticket.aspx?ticket_id=" + ticket_id);
            cmd.ExecuteNonQuery();
            Response.Redirect("agent.aspx");
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