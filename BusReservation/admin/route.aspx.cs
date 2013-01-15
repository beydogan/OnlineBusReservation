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
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Route List - " + ConfigurationSettings.AppSettings["siteName"].ToString();

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

            SqlCommand cmd = new SqlCommand("SELECT route_id, from_city, to_city, departure_time, fare, driver_name, Routes.bus_id AS b_id, bus_name, license_plate, T.city_name AS to_city_name, F.city_name AS from_city_name FROM Routes INNER JOIN Bus ON Routes.bus_id = Bus.bus_id INNER JOIN Cities AS T ON Routes.to_city = T.city_id INNER JOIN Cities AS F ON Routes.from_city = F.city_id", con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);
            if (tablo.Rows.Count == 0)
            {
                DataRow row = tablo.NewRow();
                row["departure_time"] = DateTime.Now;
                tablo.Rows.Add(row);
                RouteGrid.DataSource = tablo.DefaultView;
                RouteGrid.DataBind();
                RouteGrid.Rows[0].Visible = false;
            }
            else
            {
                RouteGrid.DataSource = tablo.DefaultView;
                RouteGrid.DataBind();
            }
            dr.Close();
            con.Close();
        }

        protected void RouteGrid_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Grid_Insert(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("New"))
            {
                String to_city = ((DropDownList)RouteGrid.FooterRow.FindControl("ddlToNew")).SelectedValue;
                String from_city = ((DropDownList)RouteGrid.FooterRow.FindControl("ddlFromNew")).SelectedValue;
                String bus_id = ((DropDownList)RouteGrid.FooterRow.FindControl("ddlBusNew")).SelectedValue;
                String date = ((TextBox)RouteGrid.FooterRow.FindControl("txtDepNew")).Text;
                String fare = ((TextBox)RouteGrid.FooterRow.FindControl("txtFareNew")).Text;
                String driver = ((TextBox)RouteGrid.FooterRow.FindControl("txtDriverNew")).Text;


                string connectionString;
                connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("INSERT INTO Routes(from_city,to_city,driver_name,departure_time,fare,bus_id) values('" + from_city + "','" + to_city + "','" + driver + "',CAST('" + DateTime.Parse(date).ToString("yyyy-MM-dd H:mm") + "' AS DATETIME),'" + fare + "', '"+bus_id+"')", con);
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
                try
                {
                    if (cmd.ExecuteNonQuery() == 1)
                    {
                        con.Close();
                        this.Load_Grid();

                    }
                }
                catch(Exception ex)
                {
                }
            }
        }

        protected void Grid_Edit(object sender, GridViewEditEventArgs e)
        {
            RouteGrid.EditIndex = e.NewEditIndex;
            this.Load_Grid();
        }

        protected void Grid_Delete(object sender, GridViewDeleteEventArgs e)
        {
            int route_id = (int)RouteGrid.DataKeys[e.RowIndex].Value;
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["bus_reservationConnectionString"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("DELETE FROM Routes WHERE route_id = '" + route_id + "'", con);
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

            if (cmd.ExecuteNonQuery() == 1)
            {
                con.Close();
                this.Load_Grid();
            }
        }

        protected void Grid_Update(object sender, GridViewUpdateEventArgs e)
        {
            int route_id = (int) RouteGrid.DataKeys[e.RowIndex].Value;
            String to_city = ((DropDownList)RouteGrid.Rows[e.RowIndex].FindControl("ddlToEdit")).SelectedValue;
            String from_city = ((DropDownList)RouteGrid.Rows[e.RowIndex].FindControl("ddlFromEdit")).SelectedValue;
            String bus_id = ((DropDownList)RouteGrid.Rows[e.RowIndex].FindControl("ddlBusEdit")).SelectedValue;
            String departure_time = ((TextBox)RouteGrid.Rows[e.RowIndex].FindControl("txtDepEdit")).Text;
            String fare = ((TextBox)RouteGrid.Rows[e.RowIndex].FindControl("txtFareEdit")).Text;
            String driver_name = ((TextBox)RouteGrid.Rows[e.RowIndex].FindControl("txtDriverEdit")).Text;
            string connectionString;

            connectionString = ConfigurationManager.ConnectionStrings["bus_reservationConnectionString"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand set_format_cmd = new SqlCommand("SET dateformat dmy", con);

            SqlCommand cmd = new SqlCommand("UPDATE Routes SET from_city = '" + from_city + "', to_city = '" + to_city + "', departure_time = CAST('" + DateTime.Parse(departure_time).ToString() + "' AS DATETIME), fare = '" + fare + "', driver_name = '" + driver_name + "', bus_id= '" + bus_id+ "'  WHERE route_id ='" + route_id + "'", con);
            con.Open();
            set_format_cmd.ExecuteNonQuery();
            cmd.ExecuteNonQuery();
            con.Close();
            RouteGrid.EditIndex = -1;
            this.Load_Grid();
        }

        protected void Grid_DataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlFromEdit = e.Row.FindControl("ddlFromEdit") as DropDownList;
            }
        }

        protected void RouteGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            RouteGrid.EditIndex = -1;
            this.Load_Grid();
        }

        protected String Get_City_Name(object city_id)
        {
            //DataView dvSql = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            //return dvSql.Table.Rows[int.Parse(city_id.ToString())]["city_name"].ToString();
            return "a";
        }
    }

}