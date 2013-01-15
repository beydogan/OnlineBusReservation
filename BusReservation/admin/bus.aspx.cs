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
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Bus List - " + ConfigurationSettings.AppSettings["siteName"].ToString();
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

            SqlCommand cmd = new SqlCommand("SELECT * FROM Bus", con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);
            if (tablo.Rows.Count == 0)
            {
                DataRow row = tablo.NewRow();
                tablo.Rows.Add(row);
                BusGrid.DataSource = tablo.DefaultView;
                BusGrid.DataBind();
                BusGrid.Rows[0].Visible = false;
            }
            else
            {
                BusGrid.DataSource = tablo.DefaultView;
                BusGrid.DataBind();
            }

            dr.Close();
            con.Close();
        }

        protected void BusGrid_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Grid_Insert(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("New"))
            {
                errorPanel.Visible = false;

                String name = ((TextBox)BusGrid.FooterRow.FindControl("txtNameNew")).Text;
                String seat = ((TextBox)BusGrid.FooterRow.FindControl("txtSeatNew")).Text;
                String type = ((TextBox)BusGrid.FooterRow.FindControl("txtTypeNew")).Text;
                String plate = ((TextBox)BusGrid.FooterRow.FindControl("txtPlateNew")).Text;

                if (name == "" || seat == "" || type == "" || plate == "")
                {
                    LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                    objPanelText.Text = "<strong>Error: </strong>All fields must be filled.";
                    errorPanel.Visible = true;
                    return;
                }
                if (!System.Text.RegularExpressions.Regex.IsMatch(seat, @"\d"))
                {
                    LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                    objPanelText.Text = "<strong>Error: </strong>Seat count must be numeric.";
                    errorPanel.Visible = true;
                    return;
                }

                string connectionString;
                connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("INSERT INTO Bus(bus_name,seat_count,type,license_plate) values('" + name + "','" + seat + "','" + type+ "', '" + plate + "')", con);
                SqlCommand check_unique_cmd = new SqlCommand("SELECT bus_id FROM Bus WHERE license_plate = '"+plate+"'", con);
                SqlDataReader reader;  
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
                    reader = check_unique_cmd.ExecuteReader();
                    if (!reader.HasRows)
                    {
                        reader.Close();
                        if (cmd.ExecuteNonQuery() == 1)                        
                        {
                            con.Close();
                            this.Load_Grid();
                        }
                    }
                    else
                    {
                        con.Close();
                        LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                        objPanelText.Text = "<strong>Error: </strong>Duplicate License Plate Number, It Must Be Unique";
                        errorPanel.Visible = true;
                    }
                        
                }
                catch (Exception ex)
                {

                }
            }
        }

        protected void Grid_Edit(object sender, GridViewEditEventArgs e)
        {
            BusGrid.EditIndex = e.NewEditIndex;
            this.Load_Grid();
        }

        protected void Grid_Delete(object sender, GridViewDeleteEventArgs e)
        {
            int bus_id = (int)BusGrid.DataKeys[e.RowIndex].Value;
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["bus_reservationConnectionString"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("DELETE FROM Bus WHERE bus_id = '" + bus_id + "'", con);
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
            int route_id = (int) BusGrid.DataKeys[e.RowIndex].Value;
            String to_city = ((DropDownList)BusGrid.Rows[e.RowIndex].FindControl("ddlToEdit")).SelectedValue;
            String from_city = ((DropDownList)BusGrid.Rows[e.RowIndex].FindControl("ddlFromEdit")).SelectedValue;
            String bus_id = ((DropDownList)BusGrid.Rows[e.RowIndex].FindControl("ddlBusEdit")).SelectedValue;
            String departure_time = ((TextBox)BusGrid.Rows[e.RowIndex].FindControl("txtDepEdit")).Text;
            String fare = ((TextBox)BusGrid.Rows[e.RowIndex].FindControl("txtFareEdit")).Text;
            String driver_name = ((TextBox)BusGrid.Rows[e.RowIndex].FindControl("txtDriverEdit")).Text;
            string connectionString;

            connectionString = ConfigurationManager.ConnectionStrings["bus_reservationConnectionString"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand set_format_cmd = new SqlCommand("SET dateformat dmy", con);

            SqlCommand cmd = new SqlCommand("UPDATE Routes SET from_city = '" + from_city + "', to_city = '" + to_city + "', departure_time = CAST('" + DateTime.Parse(departure_time).ToString() + "' AS DATETIME), fare = '" + fare + "', driver_name = '" + driver_name + "', bus_id= '" + bus_id+ "'  WHERE route_id ='" + route_id + "'", con);
            con.Open();
            set_format_cmd.ExecuteNonQuery();
            cmd.ExecuteNonQuery();
            con.Close();
            BusGrid.EditIndex = -1;
            this.Load_Grid();
        }

        protected void Grid_DataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlFromEdit = e.Row.FindControl("ddlFromEdit") as DropDownList;
            }
        }

        protected void BusGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            BusGrid.EditIndex = -1;
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