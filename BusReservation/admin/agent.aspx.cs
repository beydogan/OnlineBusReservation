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
    public partial class Agent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Agents List - " + ConfigurationSettings.AppSettings["siteName"].ToString();
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

            SqlCommand cmd = new SqlCommand("SELECT * FROM Agents", con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);
            if (tablo.Rows.Count == 0)
            {
                DataRow row = tablo.NewRow();
                tablo.Rows.Add(row);
                AgentGrid.DataSource = tablo.DefaultView;
                AgentGrid.DataBind();
                AgentGrid.Rows[0].Visible = false;
            }
            else
            {
                AgentGrid.DataSource = tablo.DefaultView;
                AgentGrid.DataBind();
            }
            dr.Close();
            con.Close();
        }

        protected void AgentGrid_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Grid_Insert(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("New"))
            {
                errorPanel.Visible = false;

                String agent_name = ((TextBox)AgentGrid.FooterRow.FindControl("txtNameNew")).Text;
                String email = ((TextBox)AgentGrid.FooterRow.FindControl("txtEmailNew")).Text;
                String phone = ((TextBox)AgentGrid.FooterRow.FindControl("txtPhoneNew")).Text;
                String address = ((TextBox)AgentGrid.FooterRow.FindControl("txtAddressNew")).Text;

                if (agent_name == "" || email == "" || phone == "" || address == "")
                {
                    LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                    objPanelText.Text = "<strong>Error: </strong>All fields must be filled.";
                    errorPanel.Visible = true;
                    return;
                }
              
                string connectionString;
                connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("INSERT INTO Agents(agent_name,email,phone_number,address) values('" + agent_name + "','" + email + "','" + phone+ "', '" + address + "')", con);
               
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

                if (cmd.ExecuteNonQuery() == 1)
                {
                    con.Close();
                    this.Load_Grid();
                }
            }
        }

        protected void Grid_Edit(object sender, GridViewEditEventArgs e)
        {
            AgentGrid.EditIndex = e.NewEditIndex;
            this.Load_Grid();
        }

        protected void Grid_Delete(object sender, GridViewDeleteEventArgs e)
        {
            int agent_id = (int)AgentGrid.DataKeys[e.RowIndex].Value;
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["bus_reservationConnectionString"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("DELETE FROM Agents WHERE agent_id = '" + agent_id + "'", con);
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
            int agent_id = (int) AgentGrid.DataKeys[e.RowIndex].Value;
            String agent_name = ((TextBox)AgentGrid.Rows[e.RowIndex].FindControl("txtNameEdit")).Text;
            String email = ((TextBox)AgentGrid.Rows[e.RowIndex].FindControl("txtEmailEdit")).Text;
            String phone_number = ((TextBox)AgentGrid.Rows[e.RowIndex].FindControl("txtPhoneEdit")).Text;
            String address = ((TextBox)AgentGrid.Rows[e.RowIndex].FindControl("txtAddressEdit")).Text;
           
            string connectionString;

            connectionString = ConfigurationManager.ConnectionStrings["bus_reservationConnectionString"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand set_format_cmd = new SqlCommand("SET dateformat dmy", con);

            SqlCommand cmd = new SqlCommand("UPDATE Agents SET agent_name = '" + agent_name + "', email = '" + email + "', phone_number = '" + phone_number + "', address = '" + address + "'  WHERE agent_id ='" + agent_id + "'", con);
            con.Open();
            set_format_cmd.ExecuteNonQuery();
            cmd.ExecuteNonQuery();
            con.Close();
            AgentGrid.EditIndex = -1;
            this.Load_Grid();
        }

        protected void Grid_DataBound(object sender, GridViewRowEventArgs e)
        {
           
        }

        protected void AgentGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            AgentGrid.EditIndex = -1;
            this.Load_Grid();
        }

        
    }

}