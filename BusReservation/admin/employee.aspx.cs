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
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Employee List - " + ConfigurationSettings.AppSettings["siteName"].ToString();
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
            String agent_id = Request.QueryString["agent_id"];
            String sql_str = "Select Employees.*,username,password,sales from Employees left join Users on users.user_id=Employees.user_id ";
            if (agent_id != null)
            {
                sql_str = "Select Employees.*,username,password,sales from Employees left join Users on users.user_id=Employees.user_id  WHERE agent_id = '" + agent_id + "'";
            }
            SqlCommand cmd = new SqlCommand(sql_str, con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable tablo = new DataTable();
            tablo.Load(dr);

            if (tablo.Rows.Count == 0)
            {
                DataRow row = tablo.NewRow();
                tablo.Rows.Add(row);
                EmpGrid.DataSource = tablo.DefaultView;
                EmpGrid.DataBind();
                EmpGrid.Rows[0].Visible = false;
            }
            else
            {
                EmpGrid.DataSource = tablo.DefaultView;
                EmpGrid.DataBind();
            }
            dr.Close();
            con.Close();
        }

        protected void EmpGrid_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Grid_Insert(object sender, GridViewCommandEventArgs e)
        {
            String agent_id = Request.QueryString["agent_id"];
            if (e.CommandName.Equals("New"))
            {
                errorPanel.Visible = false;

                String empfname = ((TextBox)EmpGrid.FooterRow.FindControl("txtFNameNew")).Text;
                String emplname = ((TextBox)EmpGrid.FooterRow.FindControl("txtLNameNew")).Text;
                String email = ((TextBox)EmpGrid.FooterRow.FindControl("txtEmailNew")).Text;
                String phone = ((TextBox)EmpGrid.FooterRow.FindControl("txtPhoneNew")).Text;
                String username = ((TextBox)EmpGrid.FooterRow.FindControl("txtUserNameNew")).Text;
                String password = ((TextBox)EmpGrid.FooterRow.FindControl("txtPasswordNew")).Text;
                String sales = ((TextBox)EmpGrid.FooterRow.FindControl("txtSalesNew")).Text;
                String gender = ((DropDownList)EmpGrid.FooterRow.FindControl("ddlGenderNew")).SelectedValue;
                if (empfname == "" || emplname == "" || email == "" || phone == "" || username == "" || password == "" || sales == "")
                {
                    LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                    objPanelText.Text = "<strong>Error: </strong>All fields must be filled.";
                    errorPanel.Visible = true;
                    return;
                }


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
                SqlCommand cmd = new SqlCommand("INSERT INTO Users(username,password,email,user_level,sales) output inserted.user_id values('" + username + "','" + password + "','" + email + "', '1','"+sales+"')", con);
                int userid = (int)cmd.ExecuteScalar();
                cmd = new SqlCommand("INSERT INTO Employees(agent_id,first_name,last_name,email,phone_number,gender,user_id) values('" + agent_id + "','" + empfname + "','" + emplname + "','" + email + "','" + phone + "','" + gender + "','" + userid + "')", con);
                
               


                    if (cmd.ExecuteNonQuery() == 1)
                    {
                        con.Close();
                        this.Load_Grid();
                    }

                
            }
        }

        protected void Grid_Edit(object sender, GridViewEditEventArgs e)
        {
            EmpGrid.EditIndex = e.NewEditIndex;
            this.Load_Grid();
        }

        protected void Grid_Delete(object sender, GridViewDeleteEventArgs e)
        {
            int employee_id = (int)EmpGrid.DataKeys[e.RowIndex].Value;
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["bus_reservationConnectionString"].ToString();
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("DELETE FROM Employees WHERE employee_id = '" + employee_id + "'", con);
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
            int employee_id = (int) EmpGrid.DataKeys[e.RowIndex].Value;
            String empfname = ((TextBox)EmpGrid.Rows[e.RowIndex].FindControl("txtFNameEdit")).Text;
            String emplname = ((TextBox)EmpGrid.Rows[e.RowIndex].FindControl("txtLNameEdit")).Text;
            String email = ((TextBox)EmpGrid.Rows[e.RowIndex].FindControl("txtEmailEdit")).Text;
            String phone = ((TextBox)EmpGrid.Rows[e.RowIndex].FindControl("txtPhoneEdit")).Text;
            String username = ((TextBox)EmpGrid.Rows[e.RowIndex].FindControl("txtUserNameEdit")).Text;
            String password = ((TextBox)EmpGrid.Rows[e.RowIndex].FindControl("txtPasswordEdit")).Text;
            String sales = ((TextBox)EmpGrid.Rows[e.RowIndex].FindControl("txtSalesEdit")).Text;
            String gender = ((DropDownList)EmpGrid.Rows[e.RowIndex].FindControl("ddlGenderEdit")).SelectedValue;
            String userid = ((HiddenField)EmpGrid.Rows[e.RowIndex].FindControl("User_id")).Value;
            if (empfname == "" || emplname == "" || email == "" || phone == "" || username == "" || password == "" || sales == "")
            {
                LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                objPanelText.Text = "<strong>Error: </strong>All fields must be filled.";
                errorPanel.Visible = true;
                return;
            }
            string connectionString;

            connectionString = ConfigurationManager.ConnectionStrings["bus_reservationConnectionString"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand set_format_cmd = new SqlCommand("SET dateformat dmy", con);

            SqlCommand cmd = new SqlCommand("UPDATE Employees SET first_name = '" + empfname + "', last_name = '" + emplname + "',  email = '" + email + "', phone_number = '" + phone + "', gender= " + int.Parse(gender) + "  WHERE employee_id ='" + employee_id + "'", con);
            SqlCommand cmd2 = new SqlCommand("UPDATE Users set username= '" + username + "',password='" + password + "',email='" + email + "',sales='" + sales + "' WHERE user_id= '" + userid + "'", con);
            con.Open();
            set_format_cmd.ExecuteNonQuery();
            cmd2.ExecuteNonQuery();
            cmd.ExecuteNonQuery();
            con.Close();
            EmpGrid.EditIndex = -1;
            this.Load_Grid();
        }

        protected void Grid_DataBound(object sender, GridViewRowEventArgs e)
        {
            
        }

        protected void EmpGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            EmpGrid.EditIndex = -1;
            this.Load_Grid();
        }

      

        protected void EmpGrid_SelectedIndexChanged1(object sender, EventArgs e)
        {
        
        }
    }

}